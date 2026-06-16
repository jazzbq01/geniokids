const SUPABASE_URL = import.meta.env.VITE_SUPABASE_URL;

export function getAssetUrl(path?: string | null) {
  if (!path) return '';

  if (path.startsWith('http')) return path;

  return `${SUPABASE_URL}/storage/v1/object/public/geniokids-assets/${path}`;
}