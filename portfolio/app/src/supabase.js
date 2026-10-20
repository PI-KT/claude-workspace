import { createClient } from '@supabase/supabase-js';

// 값은 portfolio/app/.env.local 에서만 읽어요 (코드에 직접 쓰지 않음)
const url = import.meta.env.VITE_SUPABASE_URL;
const anonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

export const supabaseReady = Boolean(url && anonKey);

export const supabase = supabaseReady ? createClient(url, anonKey) : null;
