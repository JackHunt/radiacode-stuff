CREATE OR REPLACE FUNCTION add_device(p_device_id varchar)
RETURNS integer AS $$
    DECLARE
        device_key integer;
    BEGIN

    SELECT id INTO device_key FROM devices WHERE device_id = p_device_id;

    IF device_key IS NULL THEN
        INSERT INTO devices (device_id) VALUES (p_device_id)
        RETURNING id INTO device_key;
    END IF;

    RETURN device_key;
END;
$$ LANGUAGE plpgsql;
