import { createClient } from '@supabase/supabase-js';

// const supabaseUrl = import.meta.env.VITE_SUPABASE_URL;
// const supabaseAnonKey = import.meta.env.VITE_SUPABASE_ANON_KEY;

const supabaseUrl = 'https://rhzxbuqngbmfgzxjyfrk.supabase.co';
const supabaseAnonKey = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InJoenhidXFuZ2JtZmd6eGp5ZnJrIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjA1NjgwNTUsImV4cCI6MjA3NjE0NDA1NX0.MQYBSkg1oamW_OXFOkgFzFoxLYIblV4HDkNcJ_CAcf0';

export const supabase = createClient(supabaseUrl, supabaseAnonKey);

export type Blog = {
  id: string;
  title: string;
  excerpt: string;
  content: string;
  author: string;
  category: string;
  tags: string[];
  image_url: string;
  published_date: string;
  read_time: number;
  created_at: string;
  updated_at: string;
};

export type Project = {
  id: string;
  title: string;
  description: string;
  long_description: string;
  technologies: string[];
  image_url: string;
  demo_url: string | null;
  github_url: string | null;
  featured: boolean;
  display_order: number;
  created_at: string;
  updated_at: string;
};
