-- ============================================================
-- BIONEP Admin — Script de Setup do Banco de Dados
-- Execute no Supabase Dashboard > SQL Editor
-- ============================================================

-- ── TABELA: posts (Artigos do Blog) ──────────────────────────
CREATE TABLE IF NOT EXISTS posts (
  id              uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  titulo          text        NOT NULL,
  categoria       text        DEFAULT 'NOTÍCIAS',
  descricao       text,
  conteudo        text,
  imagem_url      text,
  status          text        DEFAULT 'publicado' CHECK (status IN ('publicado', 'rascunho')),
  data_publicacao date,
  criado_em       timestamptz DEFAULT now()
);

-- ── TABELA: cursos ────────────────────────────────────────────
CREATE TABLE IF NOT EXISTS cursos (
  id                uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  titulo            text        NOT NULL,
  categoria         text        DEFAULT 'ESPECIALIZAÇÃO',
  descricao         text,
  inscricoes_abertas boolean    DEFAULT true,
  criado_em         timestamptz DEFAULT now()
);

-- ── ROW LEVEL SECURITY ───────────────────────────────────────
ALTER TABLE posts  ENABLE ROW LEVEL SECURITY;
ALTER TABLE cursos ENABLE ROW LEVEL SECURITY;

-- Leitura pública (site front-end)
CREATE POLICY "posts: leitura publica"
  ON posts FOR SELECT USING (true);

CREATE POLICY "cursos: leitura publica"
  ON cursos FOR SELECT USING (true);

-- Escrita apenas para usuários autenticados (admin logado)
CREATE POLICY "posts: admin escreve"
  ON posts FOR ALL
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "cursos: admin escreve"
  ON cursos FOR ALL
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- ── STORAGE BUCKET (imagens de capa) ─────────────────────────
-- Execute separado se quiser upload de imagens:
-- INSERT INTO storage.buckets (id, name, public) VALUES ('post-images', 'post-images', true);
-- CREATE POLICY "upload autenticado" ON storage.objects FOR INSERT
--   WITH CHECK (bucket_id = 'post-images' AND auth.role() = 'authenticated');
-- CREATE POLICY "leitura publica storage" ON storage.objects FOR SELECT
--   USING (bucket_id = 'post-images');
