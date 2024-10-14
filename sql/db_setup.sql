CREATE TABLE devices (
    id serial PRIMARY KEY,
    device_id varchar(255) NOT NULL
);

CREATE TABLE periods (
    id serial PRIMARY KEY,
    distance real NOT NULL,
    start_time bigint NOT NULL,
    end_time bigint NOT NULL
);

CREATE TABLE markers (
    id serial PRIMARY KEY,
    latitude decimal(9, 6) NOT NULL,
    longitude decimal(9, 6) NOT NULL,
    marker_time bigint NOT NULL,
    count_rate real NOT NULL,
    dose_rate real NOT NULL
);

CREATE TABLE sessions (
    id serial PRIMARY KEY,
    start_time bigint NOT NULL,
    title varchar(255) NOT NULL,
    sv boolean NOT NULL
);

CREATE TABLE device_session_relation (
    device_id integer NOT NULL,
    session_id integer NOT NULL,
    FOREIGN KEY (device_id) REFERENCES devices(id),
    FOREIGN KEY (session_id) REFERENCES sessions(id),
    UNIQUE (device_id, session_id)
);

CREATE TABLE period_session_relation (
    period_id integer NOT NULL,
    session_id integer NOT NULL,
    FOREIGN KEY (period_id) REFERENCES periods(id),
    FOREIGN KEY (session_id) REFERENCES sessions(id),
    UNIQUE (period_id, session_id)
);

CREATE TABLE marker_session_relation (
    marker_id integer NOT NULL,
    session_id integer NOT NULL,
    FOREIGN KEY (marker_id) REFERENCES markers(id),
    FOREIGN KEY (session_id) REFERENCES sessions(id),
    UNIQUE (marker_id, session_id)
);