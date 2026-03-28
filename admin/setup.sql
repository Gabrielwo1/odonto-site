-- ============================================================
-- BIONEP Admin — Script de Setup do Banco de Dados
--
-- ⚠️  COMO RODAR:
--   1. Acesse https://supabase.com → seu projeto
--   2. Vá em: SQL Editor (menu lateral)
--   3. Cole este script inteiro e clique em "Run"
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
  id                  uuid        DEFAULT gen_random_uuid() PRIMARY KEY,
  titulo              text        NOT NULL,
  categoria           text        DEFAULT 'ESPECIALIZAÇÃO',
  descricao           text,
  imagem_url          text,
  professor           text,
  carga_horaria       text,
  data_inicio         text,
  modulos             text,
  inscricoes_abertas  boolean     DEFAULT true,
  criado_em           timestamptz DEFAULT now()
);

-- ── ROW LEVEL SECURITY ───────────────────────────────────────
ALTER TABLE posts  ENABLE ROW LEVEL SECURITY;
ALTER TABLE cursos ENABLE ROW LEVEL SECURITY;

-- Leitura pública (site front-end)
CREATE POLICY "posts_select_public"  ON posts  FOR SELECT USING (true);
CREATE POLICY "cursos_select_public" ON cursos FOR SELECT USING (true);

-- Escrita apenas para usuários autenticados (admin logado)
CREATE POLICY "posts_all_auth"
  ON posts FOR ALL
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

CREATE POLICY "cursos_all_auth"
  ON cursos FOR ALL
  USING (auth.role() = 'authenticated')
  WITH CHECK (auth.role() = 'authenticated');

-- ── STORAGE BUCKET (imagens de capa) ─────────────────────────
-- Rode estes comandos SEPARADAMENTE se quiser upload de imagens:
--
-- INSERT INTO storage.buckets (id, name, public)
--   VALUES ('post-images', 'post-images', true)
--   ON CONFLICT DO NOTHING;
--
-- CREATE POLICY "upload_autenticado" ON storage.objects FOR INSERT
--   WITH CHECK (bucket_id = 'post-images' AND auth.role() = 'authenticated');
--
-- CREATE POLICY "leitura_publica_storage" ON storage.objects FOR SELECT
--   USING (bucket_id = 'post-images');
