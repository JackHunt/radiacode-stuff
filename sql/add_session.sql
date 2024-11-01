CREATE OR REPLACE FUNCTION add_session(p_title varchar, p_start_time bigint, p_devices integer[])
RETURNS integer AS $$
    DECLARE
        session_key integer;
        device_key integer;
    BEGIN

    SELECT id INTO session_key FROM sessions WHERE start_time = p_start_time AND title = p_title;

    IF session_key IS NULL THEN
        INSERT INTO sessions (start_time, title) VALUES (p_start_time, p_title)
        RETURNING id INTO session_key;
    END IF;

    FOREACH device_key IN ARRAY p_devices LOOP
        IF NOT EXISTS( SELECT 1 FROM device_session_relation WHERE device_id = device_key AND session_id = session_key)
        THEN
            INSERT INTO device_session_relation (device_id, session_id) VALUES (device_key, session_key);
        END IF;
    END LOOP;

    RETURN session_key;
END;
$$ LANGUAGE plpgsql;
