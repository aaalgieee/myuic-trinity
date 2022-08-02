import { client, eventbus } from '../client';
import { Storage } from '@capacitor/storage';
import { useMutation, useQuery, useQueryClient } from 'vue-query';
import { useRouter } from 'vue-router';
import { notify } from 'notiwind';
import appEvents from '../event';

const SESSION_NAME = 'session';
const SESSION_SEP = '||-||';

export function subscribeAuth() {
  const queryClient = useQueryClient();
  const { mutate: logout } = useLogoutMutation();

  const handleChangeAuthenticatedStatus = ({ newStatus, oldStatus }) => {
    if (oldStatus && !newStatus) {
      logout();
      queryClient.clear();
    }
  };

  const handleSessionRefresh = () => {
    notify({
      type: 'info',
      text: 'Refreshing your session...'
    }, 1000);
  };

  const handleSessionExpired = () => {
    notify({
      type: 'error',
      text: 'Your session has expired. Please log in again.'
    }, 3000);
  };

  eventbus.on('changeAuthenticatedStatus', handleChangeAuthenticatedStatus);
  eventbus.on('sessionRefresh', handleSessionRefresh);
  eventbus.on('sessionExpired', handleSessionExpired);

  return () => {
    eventbus.off('changeAuthenticatedStatus', handleChangeAuthenticatedStatus);
    eventbus.off('sessionRefresh', handleSessionRefresh);
    eventbus.off('sessionExpired', handleSessionExpired);
  }
} 

export function persistTokens(token: string, refreshToken: string) {
  if (token && refreshToken)
    Storage.set({
      key: SESSION_NAME,
      value: token + SESSION_SEP + refreshToken
    });
}

export function useLoginMutation() {
  const { mutateAsync, isLoading } = useMutation(
    ({ id, password }:{ id: string, password: string }) => client.login(id, password), 
  {
    onSuccess: async ({ token, refreshToken }, { id, password }) => {
      persistTokens(token, refreshToken);
      await appEvents.onAuthSuccess?.({ id, password });
    }
  });

  return {
    login: (id: string, password: string) => mutateAsync({ id, password }),
    isProcessing: isLoading
  }
}

export async function retrieveFromStorage() {
  const { value: sessionCreds } = await Storage.get({ key: SESSION_NAME });
  if (!sessionCreds) 
    return { accessToken: '', refreshToken: '' };

  const [accessToken, refreshToken] = sessionCreds.split(SESSION_SEP);
  return { accessToken, refreshToken };
}

export async function retrieve() {
  if (client.isAuthenticated()) return;
  const { accessToken, refreshToken } = await retrieveFromStorage();
  if (!accessToken || !refreshToken) return;
  client.setAuthCredentials(accessToken, refreshToken);
}

export function useLogoutMutation() {
  const router = useRouter();
  return useMutation(() => client.logout(), {
    onSuccess: async () => {
      await appEvents.onAuthDestroy?.();
      await Storage.remove({ key: SESSION_NAME });
      router.replace({ name: 'login' });
    }
  });
}

export interface Profile {
  avatarUrl: string
  name?: string
  id: string
  password?: string
}

const profilesSuffixKey = 'profiles/'

async function getProfiles(): Promise<Profile[]> {
  const profiles: Profile[] = [];

  const { keys } = await Storage.keys();
  const rawProfiles = await Promise.all(keys.filter(k => k.startsWith(profilesSuffixKey)).map(key => Storage.get({ key })));

  for (const { value: rawProfile } of rawProfiles) {
    if (rawProfile) {
      profiles.push(JSON.parse(rawProfile));
    }
  }

  return profiles;
}

export function useProfiles() {
  return useQuery(['profiles'], getProfiles);
}

export function useProfileMutation() {
  return useMutation(async (profile: Profile) => {
    await Storage.set({
      key: profilesSuffixKey + profile.id,
      value: JSON.stringify(profile)
    });
  });
}

export async function removeProfile(id: string) {
  await Storage.remove({ key: profilesSuffixKey + id });
}