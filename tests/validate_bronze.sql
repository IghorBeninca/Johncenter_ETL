-- Script de Validação de Carga (Bronze)
-- Verifica se as tabelas principais receberam dados

DO $$
DECLARE
    r RECORD;
    v_count INTEGER;
BEGIN
    RAISE NOTICE 'Iniciando validação das tabelas Staging...';

    FOR r IN 
        SELECT table_name 
        FROM information_schema.tables 
        WHERE table_schema = 'public' AND table_name LIKE 'stg_%'
    LOOP
        EXECUTE 'SELECT count(*) FROM ' || quote_ident(r.table_name) INTO v_count;
        
        IF v_count = 0 THEN
            RAISE WARNING '⚠️ Tabela % está VAZIA!', r.table_name;
        ELSE
            RAISE NOTICE '✅ Tabela %: % registros.', r.table_name, v_count;
        END IF;
    END LOOP;
END $$;
