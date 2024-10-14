CREATE FUNCTION add_device(p_device_id varchar)
RETURNS integer AS $$
DECLARE
    device_key integer;
BEGIN
    -- Check if the device already exists.
    SELECT id INTO device_key FROM devices WHERE device_id = p_device_id;

    -- If the device doesn't exist, add it.
    IF device_key IS NULL THEN
        INSERT INTO devices (device_id) VALUES (p_device_id)
        RETURNING id INTO device_key;
    END IF;

    RETURN device_key;
END;