// BIONEP Admin — Cliente Supabase Central
(function () {
  const URL = "https://jyrcknvxnkobngpzrqok.supabase.co";
  const KEY = "sb_publishable_6zohSf7oHukZKO9h0CY-6g_yVP97NTK";

  // Expõe o cliente globalmente sem conflitar com o namespace 'supabase' do CDN
  window.supabaseClient = window.supabase.createClient(URL, KEY);

  // Proteção de rota: redireciona para login se não houver sessão
  window.checkAuth = async function () {
    const { data: { session } } = await window.supabaseClient.auth.getSession();
    if (!session) {
      window.location.href = "login.html";
    }
  };
})();
