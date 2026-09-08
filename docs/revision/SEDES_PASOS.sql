-- Ejecutar en el SQL Editor de Supabase ANTES de usar el APK corregido.
ALTER TABLE public.ventas_detalle
  ADD COLUMN IF NOT EXISTS receta_sedes jsonb;

-- Diagnóstico de solo lectura: compartir resultados para resolver FEFO/caja.
SELECT c.relname AS tabla, t.tgname AS trigger,
       pg_get_triggerdef(t.oid) AS definicion,
       pg_get_functiondef(t.tgfoid) AS funcion
FROM pg_trigger t
JOIN pg_class c ON c.oid = t.tgrelid
JOIN pg_namespace n ON n.oid = c.relnamespace
WHERE n.nspname = 'public' AND NOT t.tgisinternal
  AND c.relname IN ('ventas', 'ventas_detalle', 'producto_lotes', 'movimientos_caja');

SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
  AND table_name IN ('ventas_detalle', 'producto_lotes', 'movimientos_caja')
ORDER BY table_name, ordinal_position;

SELECT id, nombre, es_psicotropico, permite_fraccionamiento,
       unidades_por_caja, unidades_por_blister
FROM public.productos
WHERE empresa_id = 9
  AND (nombre ILIKE '%clo%' OR nombre ILIKE '%diaz%');
