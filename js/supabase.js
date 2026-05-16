const SUPABASE_URL = 'https://obttxpduyfcayhsbezni.supabase.co';
const SUPABASE_KEY = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9idHR4cGR1eWZjYXloc2Jlem5pIiwicm9sZSI6ImFub24iLCJpYXQiOjE3Nzg5NTY1NTAsImV4cCI6MjA5NDUzMjU1MH0.Ig_P6D7YtDR4pmXuEL04svp0FDz3pFHNYPVaA2x12cQ';

const supabaseClient = window.supabase.createClient(SUPABASE_URL, SUPABASE_KEY);

// Subscribe to newsletter
async function subscribe(email) {
  const { error } = await supabaseClient.from('subscribers').insert({ email });
  return { success: !error, error };
}

// Submit contact form
async function submitContact(name, email, message) {
  const { error } = await supabaseClient.from('contacts').insert({ name, email, message });
  return { success: !error, error };
}

// Get all essays
async function getEssays() {
  const { data, error } = await supabaseClient
    .from('essays')
    .select('*')
    .order('published_at', { ascending: false });
  return { data: data || [], error };
}

// Get single essay by slug
async function getEssayBySlug(slug) {
  const { data, error } = await supabaseClient
    .from('essays')
    .select('*')
    .eq('slug', slug)
    .single();
  return { data, error };
}

// Get comments for an essay
async function getComments(essayId) {
  const { data, error } = await supabaseClient
    .from('comments')
    .select('*')
    .eq('essay_id', essayId)
    .order('created_at', { ascending: true });
  return { data: data || [], error };
}

// Add comment
async function addComment(essayId, name, content) {
  const { error } = await supabaseClient.from('comments').insert({
    essay_id: essayId,
    name,
    content
  });
  return { success: !error, error };
}