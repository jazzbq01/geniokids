export const env = {
  supabaseUrl: import.meta.env.VITE_SUPABASE_URL as string | undefined,
  supabaseAnonKey: import.meta.env.VITE_SUPABASE_ANON_KEY as string | undefined,
  appMode: (import.meta.env.VITE_APP_MODE as string | undefined) ?? 'demo'
};

export const isSupabaseConfigured = Boolean(env.supabaseUrl && env.supabaseAnonKey && env.appMode === 'supabase');
