-- ============================================================
-- Paronetto's Green — RLS Migration
-- Rodar no Supabase: Dashboard > SQL Editor > New query
-- ============================================================

-- 1. Adicionar coluna user_id nas duas tabelas
ALTER TABLE expenses   ADD COLUMN IF NOT EXISTS user_id uuid REFERENCES auth.users(id);
ALTER TABLE categories ADD COLUMN IF NOT EXISTS user_id uuid REFERENCES auth.users(id);

-- 2. Ativar RLS
ALTER TABLE expenses   ENABLE ROW LEVEL SECURITY;
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

-- 3. Policies para expenses
CREATE POLICY "expenses: select own" ON expenses
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "expenses: insert own" ON expenses
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "expenses: update own" ON expenses
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "expenses: delete own" ON expenses
  FOR DELETE USING (auth.uid() = user_id);

-- 4. Policies para categories
CREATE POLICY "categories: select own" ON categories
  FOR SELECT USING (auth.uid() = user_id);

CREATE POLICY "categories: insert own" ON categories
  FOR INSERT WITH CHECK (auth.uid() = user_id);

CREATE POLICY "categories: update own" ON categories
  FOR UPDATE USING (auth.uid() = user_id);

CREATE POLICY "categories: delete own" ON categories
  FOR DELETE USING (auth.uid() = user_id);
