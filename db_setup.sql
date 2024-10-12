CREATE DATABASE Radiacode;

USE Radiacode;

CREATE TABLE Devices (
    id serial PRIMARY KEY,
    device_id varchar(255) NOT NULL,
);

CREATE TABLE Periods (
    id serial PRIMARY KEY,
    distance real NOT NULL,
    start_time int(11) NOT NULL,
    end_time int(11) NOT NULL,
);

CREATE TABLE Markers (
    id serial PRIMARY KEY,
    latitude decimal(9, 6) NOT NULL,
    longitude decimal(9, 6) NOT NULL,
    marker_time int(11) NOT NULL,
    count_rate real NOT NULL,
    dose_rate real NOT NULL,
);

CREATE TABLE Sessions (
    id serial PRIMARY KEY,
    start_time int(11) NOT NULL,
    title varchar(255) NOT NULL,
    sv boolean NOT NULL,
);

CREATE TABLE DeviceSessionRelation (
    device_id integer NOT NULL,
    session_id integer NOT NULL,
    FOREIGN KEY (device_id) REFERENCES Devices(id),
    FOREIGN KEY (session_id) REFERENCES Sessions(id),
    UNIQUE (device_id, session_id)
);

CREATE TABLE PeriodSessionRelation (
    period_id integer NOT NULL,
    session_id integer NOT NULL,
    FOREIGN KEY (period_id) REFERENCES Periods(id),
    FOREIGN KEY (session_id) REFERENCES Sessions(id),
    UNIQUE (period_id, session_id)
);

CREATE TABLE MarkerSessionRelation (
    marker_id integer NOT NULL,
    session_id integer NOT NULL,
    FOREIGN KEY (marker_id) REFERENCES Markers(id),
    FOREIGN KEY (session_id) REFERENCES Sessions(id),
    UNIQUE (marker_id, session_id)
);