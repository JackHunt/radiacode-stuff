CREATE OR REPLACE FUNCTION add_session(p_title varchar,
p_start_time bigint, p_sv boolean, p_devices integer[])
RETURNS integer AS $$
    DECLARE
        session_key integer;
        device_id integer;
    BEGIN

    SELECT id INTO session_key FROM sessions WHERE start_time = p_start_time AND title = p_title AND sv = p_sv;

    IF session_key IS NULL THEN
        INSERT INTO sessions (start_time, title, sv) VALUES (p_start_time, p_title, p_sv)
        RETURNING id INTO session_key;
    END IF;

    FOREACH device_id IN ARRAY p_devices LOOP
        INSERT INTO device_session_relation (device_id, session_id) VALUES (device_id, session_key);
    END LOOP;

    RETURN session_key;
END;
$$ LANGUAGE plpgsql;
