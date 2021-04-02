-- This creates a useable view, but the offset of 1 is annoying.
-- That "-1" is probably better done in the helper functions...

CREATE OR REPLACE VIEW pg_stat_toast AS
 SELECT 
    n.nspname AS schemaname,
    a.attrelid AS reloid,
    a.attnum AS attnum,
    c.relname AS relname,
    a.attname AS attname,
    pg_stat_get_toast_externalizations(a.attrelid,a.attnum -1) AS externalizations,
    pg_stat_get_toast_compressions(a.attrelid,a.attnum -1) AS compressions,
    pg_stat_get_toast_compressionsuccesses(a.attrelid,a.attnum -1) AS compressionsuccesses,
    pg_stat_get_toast_compressedsizesum(a.attrelid,a.attnum -1) AS compressionsizesum,
    pg_stat_get_toast_originalsizesum(a.attrelid,a.attnum -1) AS originalsizesum
   FROM pg_attribute a
   JOIN pg_class c ON c.oid = a.attrelid
   LEFT JOIN pg_namespace n ON n.oid = c.relnamespace
  WHERE pg_stat_get_toast_externalizations(a.attrelid,a.attnum -1) IS NOT NULL;
