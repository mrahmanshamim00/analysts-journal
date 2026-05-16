-- Create subscribers table
CREATE TABLE IF NOT EXISTS subscribers (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  email TEXT NOT NULL UNIQUE,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create contacts table
CREATE TABLE IF NOT EXISTS contacts (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  name TEXT NOT NULL,
  email TEXT NOT NULL,
  message TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create essays table
CREATE TABLE IF NOT EXISTS essays (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  title TEXT NOT NULL,
  slug TEXT NOT NULL UNIQUE,
  excerpt TEXT,
  content TEXT NOT NULL,
  published_at TIMESTAMPTZ DEFAULT NOW()
);

-- Create comments table
CREATE TABLE IF NOT EXISTS comments (
  id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
  essay_id UUID REFERENCES essays(id) ON DELETE CASCADE,
  name TEXT NOT NULL,
  content TEXT NOT NULL,
  created_at TIMESTAMPTZ DEFAULT NOW()
);

-- Enable Row Level Security
ALTER TABLE subscribers ENABLE ROW LEVEL SECURITY;
ALTER TABLE contacts ENABLE ROW LEVEL SECURITY;
ALTER TABLE essays ENABLE ROW LEVEL SECURITY;
ALTER TABLE comments ENABLE ROW LEVEL SECURITY;

-- Create policies for public access (insert only, no select)
CREATE POLICY "Allow public insert on subscribers" ON subscribers FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public insert on contacts" ON contacts FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public read on essays" ON essays FOR SELECT USING (true);
CREATE POLICY "Allow public insert on essays" ON essays FOR INSERT WITH CHECK (true);
CREATE POLICY "Allow public read on comments" ON comments FOR SELECT USING (true);
CREATE POLICY "Allow public insert on comments" ON comments FOR INSERT WITH CHECK (true);