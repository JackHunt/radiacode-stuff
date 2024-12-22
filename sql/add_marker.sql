CREATE OR REPLACE FUNCTION add_marker(p_lat decimal, p_lon decimal, p_time integer, p_count_rate real, p_dose_rate real)
RETURNS integer AS $$
    DECLARE
      marker_key integer;
    BEGIN
    SELECT id INTO marker_key FROM sessions WHERE marker_time = p_time;
    IF marker_key is NULL THEN
      INSERT INTO markers () VALUES ()
      RETURNING id INTO marker_key
    END IF;
END;
$$ LANGUAGE plpgsql
;