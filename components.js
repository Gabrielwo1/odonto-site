const HEADER_HTML = `
<nav id="nav">
  <div class="nav-w">
    <a href="/" class="nav-logo">
      <div class="nav-logo-row">
        <img src="/logo.png" alt="BIONEP Logo" style="height: 42px; width: auto; object-fit: contain;">
      </div>
    </a>
    <ul class="nav-links">
      <li><a href="/cursos.html">Cursos</a></li>
      <li><a href="/#structure">Estrutura</a></li>
      <li><a href="/#infra">Galeria</a></li>
      <li><a href="/blog.html">Blog</a></li>
      <li><a href="/contato.html">Contato</a></li>
    </ul>
    <a href="/contato.html" class="nav-btn">Fale com um consultor</a>
  </div>
</nav>
`;

const FOOTER_HTML = `
<footer id="footer">
  <div class="wrap">
    <div class="footer-top">
      <div>
        <div class="footer-logo">
          <img src="/logo.png" alt="BIONEP Logo" style="height: 48px; width: auto; object-fit: contain; background: rgba(255,255,255,0.92); padding: 6px 10px; border-radius: 6px; box-shadow: 0 4px 12px rgba(0,0,0,0.3);">
        </div>
        <p class="footer-desc">Elevando o padrão da odontologia nacional através da ciência, tecnologia e humanização.</p>
      </div>
      <div>
        <p class="footer-col-title">Cursos</p>
        <ul class="footer-links">
          <li><a href="/cursos/especializacao-cirurgia-bucal">Cirurgia Bucal</a></li>
          <li><a href="/cursos/especializacao-implantodontia">Implantodontia</a></li>
          <li><a href="/cursos/especializacao-odontopediatria">Odontopediatria</a></li>
          <li><a href="/cursos/ortho-advanced">Ortho Advanced</a></li>
        </ul>
      </div>
      <div>
        <p class="footer-col-title">A Instituição</p>
        <ul class="footer-links">
          <li><a href="/#structure">Sobre Nós</a></li>
          <li><a href="/#professors">Corpo Docente</a></li>
          <li><a href="/#infra">Estrutura Clínica</a></li>
          <li><a href="/contato.html">Trabalhe Conosco</a></li>
        </ul>
      </div>
      <div>
        <p class="footer-col-title">Suporte</p>
        <ul class="footer-links">
          <li><a href="/contato.html">Contato</a></li>
          <li><a href="#">Privacidade</a></li>
          <li><a href="#">Termos</a></li>
          <li><a href="#">Área do Aluno</a></li>
        </ul>
      </div>
    </div>
    <div class="footer-bottom">
      <p class="footer-copy">© 2024 BIONEP. Excellence in Education.</p>
      <div class="footer-right">
        <span>Brazil • Pato Branco</span>
        <span>Made with Excellence</span>
      </div>
    </div>
  </div>
</footer>
`;

document.addEventListener("DOMContentLoaded", () => {
  const navContainer = document.getElementById('bionep-nav-placeholder');
  const footerContainer = document.getElementById('bionep-footer-placeholder');

  if(navContainer) navContainer.outerHTML = HEADER_HTML;
  if(footerContainer) footerContainer.outerHTML = FOOTER_HTML;

  // Active link highlight
  const currentPath = window.location.pathname;
  document.querySelectorAll('.nav-links a').forEach(l => {
    const href = l.getAttribute('href');
    if (href && currentPath === href) l.classList.add('active');
    else if (href && href !== '/' && currentPath.startsWith(href.replace('.html',''))) l.classList.add('active');
  });

  // Nav scroll shadow
  const nav = document.getElementById('nav');
  if(nav) {
    window.addEventListener('scroll', () => {
      nav.classList.toggle('scrolled', window.scrollY > 20);
    });
  }
});
