import type { CapacitorConfig } from '@capacitor/cli';

const config: CapacitorConfig = {
  appId: 'com.familia.geniokids',
  appName: 'GenioKids',
  webDir: 'dist',
  server: {
    androidScheme: 'https'
  }
};

export default config;
