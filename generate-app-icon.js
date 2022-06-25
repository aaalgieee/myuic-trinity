const puppeteer = require('puppeteer-core');
const { compressSync } = require('fflate');
const base64 = require('base64-js');
const path = require('path');
const extractZip = require('extract-zip');
const del = require('del');
const { readdirSync, cpSync } = require('fs');

const textEncoder = new TextEncoder();
const androidAssets = [
    'play_store_512.png',
    path.join('res', 'mipmap-anydpi-v26'),
    path.join('res', 'mipmap-hdpi'),
    path.join('res', 'mipmap-mdpi'),
    path.join('res', 'mipmap-xhdpi'),
    path.join('res', 'mipmap-xxhdpi'),
    path.join('res', 'mipmap-xxxhdpi'),
];

const androidMainFolder = (p) => path.join(__dirname, 'android', 'app', 'src', 'main', p);
const iosMainFolder = (p) => path.join(__dirname, 'ios', 'App', p);

const toBeDeletedWeb = [path.join('public', 'icons')];
const toBeDeletedAndroid = androidAssets.map(androidMainFolder);
const toBeDeletedIos = [path.join('App', 'Assets.xcassets', 'AppIcon.appiconset', '*')].map(iosMainFolder);

function configToUrl(config) {
    return encodeURIComponent(base64.fromByteArray(
        compressSync(textEncoder.encode(JSON.stringify(config)), { mtime: 0 })
    ));
}

async function downloadAsset(config) {
    console.log('> Generating assets...');
    const downloadPath = path.join(__dirname, '.cache');
    const browser = await puppeteer.launch({
        executablePath: process.env.CHROME_PATH,
        headless: true
    });

    const page = await browser.newPage();
    const configHash = configToUrl(config);
    await page.goto(`https://icon.kitchen/i/${configHash}`);
    const client = await page.target().createCDPSession();
    const iconUploadHandle = await page.$('[data-type="image"] input[type="file"]');

    // upload icon and download assets
    if (iconUploadHandle) {
        await iconUploadHandle.uploadFile(path.relative(process.cwd(), path.join(__dirname, 'resources', 'icon-foreground.png')));
        await client.send('Page.setDownloadBehavior', {
            behavior: 'allow',
            downloadPath
        });
        console.log('> Downloading assets...');
        await page.click('[aria-label="Download"]');
        await page.waitForTimeout(3000);
    }

    return downloadPath;
}

async function extractDownloadedAsset(downloadPath) {
    console.log('> Extracting zip content...');
    // extract zip
    const extractedFolder = path.join(downloadPath, 'extracted');
    const zipFileName = 'IconKitchen-Output.zip';
    await extractZip(path.join(downloadPath, zipFileName), { dir: extractedFolder });
    return extractedFolder;
}

async function copyAssets(extractedFolder) {
    console.log('> Copying android assets...')
    readdirSync(path.join(extractedFolder, 'android')).forEach((assetPath, i, arr) => {
        const src = path.join(extractedFolder, 'android', assetPath);
        const dest = androidMainFolder(assetPath);
        console.log(`> (${i + 1}/${arr.length}) Copying ${src} to ${dest}...`);
        cpSync(src, dest, { recursive: true });
    });

    readdirSync(path.join(extractedFolder, 'ios')).forEach((assetPath, i, arr) => {
        const src = path.join(extractedFolder, 'ios', assetPath);
        const dest = iosMainFolder(path.join('App', 'Assets.xcassets', 'AppIcon.appiconset', assetPath));
        console.log(`> (${i + 1}/${arr.length}) Copying ${src} to ${dest}...`);
        cpSync(src, dest, { recursive: true });
    });

    readdirSync(path.join(extractedFolder, 'web')).forEach((assetPath, i, arr) => {
        if (assetPath === 'README.txt') return;
        const src = path.join(extractedFolder, 'web', assetPath);
        const dest = path.join(__dirname, 'public', 'icons', assetPath);
        console.log(`> (${i + 1}/${arr.length}) Copying ${src} to ${dest}...`);
        cpSync(src, dest, { recursive: true });
    });
}

(async () => {
    let success = true;

    await del(['.cache', ...toBeDeletedWeb, ...toBeDeletedAndroid, ...toBeDeletedIos], { cwd: __dirname });
    
    try {
        const downloadPath = await downloadAsset({
            values: {
                fgType: 'image',
                fgMask: false,
                bgType: 'gradient',
                fgPadding: { top: 0, right: 0, bottom: 0, left: 0 },
                bgShape: 'circle',
                fgScaling: 'center',
                bgGradient: { color1: '#e65b7a', color2: '#f1a2b3', angle: -45 }
            },
            modules: ['android', 'ios', 'web']
        });
    
        const extractedFolder = await extractDownloadedAsset(downloadPath);
        copyAssets(extractedFolder);
    } catch (e) {
        success = false;
        console.error(e);
    } finally {
        console.log('> Deleting cache...');
        await del(['.cache'], { cwd: __dirname });
        console.log('> Done!');
        process.exit(success ? 0 : 1);
    }
})();