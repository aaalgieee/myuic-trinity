<div align="center">
  <p><img width="20%" src="./_myuic-neo-web/resources/icon-square.jpg" /></p>
  <h1>MyUIC Trinity</h1>
  <p>An "unofficial", third-party student portal app for UICians.</p>
  <p><img src="https://pbs.twimg.com/media/FO8ZdXvUYAEpgGu?format=jpg&name=large" /></p>

[Demo](https://myuic.nedpals.xyz) |
[Twitter Thread](https://twitter.com/npned/status/1508455998234587140?s=20&t=_ApTg0r4DMKFbSM8QWeqnA) |
[Feedback Form](https://forms.gle/XnE2XuEGi9FdcYt5A)



[![GitHub Follow](https://img.shields.io/github/followers/aaalgieee?style=social&logo=github)](https://github.com/aaalgieee)
</div>

## Description
MyUIC Trinity is a student-made forked from [MyUIC Neo](github.com/nedpals/myuic-neo) implementation of MyUIC: the student portal web application of the [University of the Immaculate Conception](https://uic.edu.ph). The focus of MyUIC Trinity is to provide **better user experience** and **better user interface** for UIC students by using modern wonders of mobile and design techniques.

Previously, this is a [single-page application (SPA)](https://en.wikipedia.org/wiki/Single-page_application) and a [progressive web application (PWA)](https://web.dev/what-are-pwas/) for smooth native-app like experience on any device whether be on the phone, on the tablet, or on the desktop. In this forked this app will be solely a iOS Application and a Android Application (future plans)

## Why?
Information through online platforms became the norm after the start of the online class mandate. Thus, any data related to financial payments, student grades were heavily relied on the MyUIC student portal. As a student myself of the school along with others, the experience was not good and the information it provides does not utilize it very well to the point that to get the right information, you must go to a series of links which should be exposed directly in the first place.

With this, it hopefully solves the dissatisfaction and other problems experienced by the students.

## Why Trinity?
The name is inspired from the movie called "Matrix" where Neo is the main character and Trinity is the partner of Neo. This simply mean that MyUIC Trinity will be partnered ressemblance of MyUIC Neo carrying on its looks, feel and functionalitiies but eventually MyUIC Trinity will grow and implement new features along the way.

## Native Application
MyUIC Neo can also be used as a mobile application both for iOS and Android with the help of [CapacitorJS](https://capacitorjs.com). Unlike the web-only version, the mobile app provides features such as offline notifications, fingerprint authentication, persistent session, and etc.

To get started, please refer to the ["Run as Android app"](#run-as-android-app) and ["Run as iOS App"](#run-as-ios-app) sections.

## Prerequisites
### Web
- Node 16 or later
- NPM

### Android
> Android compilation is optional but is required if you want to compile it as an Android app.
- Android SDK (30 and above)

### iOS
- Xcode 13 or later
- iDevice or Simulator
- Cocoapod
- CapacitorJS `$ sudo gem install cocoapods`
  - FOR APPLE SILICON MACS ONLY: `$ sudo arch -x86_64 gem install ffi`

## Installation
To run MyUIC Neo on your local computer, simply execute the following commands:

### npm
```
git clone https://github.com/nedpals/myuic-neo.git
cd myuic-neo
npm install
npm run dev
```

This will start the Vite webserver at http://localhost:3000. You may login by typing `123456789012` as the student ID and `myuicneo` as the password.

#### Run as Android App
> See the [Android](#android) prequisites for requirements on how to build the Android app.

To run the app, simply run:
```
npm run start-android
```

This will build the web app, inject it's contents, and install the app to your simulator or your device.

#### Run as iOS App
> See the [iOS](#ios) prequisites for requirements on how to build the iOS app.

To run the app, simply run:
```
npm run start-ios
```

This will build the web app, inject it's contents, and install the app to your simulator or your device.

## Additional Resources
Wanna contribute? Here are the following resources you can use when working on the MyUIC Neo codebase:
- Vue3 Docs: https://vuejs.org/guide/introduction.html
- ViteJS Docs: https://vitejs.dev/guide/
- Vue Query Docs: https://vue-query.vercel.app/#/
- Typescript Handbook: https://www.typescriptlang.org/docs/handbook/intro.html
- TailwindCSS Docs (For additional information): https://tailwindcss.com
- CapacitorJS Android Docs: https://capacitorjs.com/docs/android

## Contributing
1. Fork it (<https://github.com/nedpals/myuic-neo/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## License
[AGPL v3](LICENSE)

## Contributors
- [Ned Palacios](https://github.com/nedpals) - creator and maintainer
- [Al Gabriel Orig](https://github.com/aaalgieee) - iOS Port
