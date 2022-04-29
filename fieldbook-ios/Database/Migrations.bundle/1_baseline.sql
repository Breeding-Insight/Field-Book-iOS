create table device_metadata
(
    locale TEXT
);

create table exp_id
(
    exp_id       INTEGER
        primary key autoincrement,
    exp_name     TEXT,
    exp_alias    TEXT,
    unique_id    TEXT,
    primary_id   TEXT,
    secondary_id TEXT,
    exp_layout   TEXT,
    exp_species  TEXT,
    exp_sort     TEXT,
    date_import  TEXT,
    date_edit    TEXT,
    date_export  TEXT,
    count        INTEGER,
    exp_source   TEXT
);

create table observation_variable_attributes
(
    internal_id_observation_variable_attribute INTEGER
        primary key autoincrement,
    observation_variable_attribute_name        Text
);

create table observation_variables
(
    observation_variable_name              TEXT,
    observation_variable_field_book_format TEXT,
    default_value                          TEXT,
    visible                                BOOLEAN,
    position                               INTEGER,
    external_db_id                         TEXT,
    trait_data_source                      TEXT,
    additional_info                        TEXT,
    common_crop_name                       TEXT,
    language                               TEXT,
    data_type                              TEXT,
    observation_variable_db_id             TEXT,
    ontology_db_id                         TEXT,
    ontology_name                          TEXT,
    observation_variable_details           TEXT,
    internal_id_observation_variable       INTEGER
        primary key autoincrement
);

create table observation_variable_values
(
    internal_id_observation_variable_value INTEGER
        primary key autoincrement,
    observation_variable_attribute_db_id   INTEGER
        references observation_variable_attributes
            on delete cascade,
    observation_variable_attribute_value   TEXT,
    observation_variable_db_id             INTEGER
        references observation_variables
            on delete cascade
);

create table observations
(
    internal_id_observation                INTEGER
        primary key autoincrement,
    observation_unit_id                    TEXT
        references observation_units,
    study_id                               INTEGER
        references study
            on delete cascade,
    observation_variable_db_id             INTEGER
        references observation_variables
            on delete cascade,
    observation_variable_name              TEXT,
    observation_variable_field_book_format TEXT,
    value                                  TEXT,
    observation_time_stamp                 TIMESTAMP,
    collector                              TEXT,
    geoCoordinates                         TEXT,
    observation_db_id                      TEXT,
    last_synced_time                       TEXT,
    additional_info                        TEXT,
    rep                                    TEXT,
    notes                                  TEXT
);

create table plot_attributes
(
    attribute_id   INTEGER
        primary key autoincrement,
    attribute_name TEXT,
    exp_id         INTEGER
);

create table plot_values
(
    attribute_value_id INTEGER
        primary key autoincrement,
    attribute_id       INTEGER,
    attribute_value    TEXT,
    plot_id            INTEGER,
    exp_id             INTEGER
);

create table plots
(
    plot_id      INTEGER
        primary key autoincrement,
    exp_id       INTEGER,
    unique_id    TEXT,
    primary_id   TEXT,
    secondary_id TEXT,
    coordinates  TEXT
);

create table range
(
    id       INTEGER
        primary key,
    range    TEXT,
    plot     TEXT,
    entry    TEXT,
    plot_id  TEXT,
    pedigree TEXT
);

create table studies
(
    study_db_id             Text,
    study_name              Text,
    study_alias             Text,
    study_unique_id_name    Text,
    study_primary_id_name   Text,
    study_secondary_id_name Text,
    experimental_design     Text,
    common_crop_name        Text,
    study_sort_name         Text,
    date_import             TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    date_edit               Text,
    date_export             Text,
    study_source            Text,
    additional_info         Text,
    location_db_id          Text,
    location_name           Text,
    observation_levels      Text,
    seasons                 Text,
    start_date              Text,
    study_code              Text,
    study_description       Text,
    study_type              Text,
    trial_db_id             Text,
    trial_name              Text,
    count                   INTEGER,
    internal_id_study       INTEGER
        primary key autoincrement
);

create table observation_units
(
    internal_id_observation_unit INTEGER
        primary key autoincrement,
    study_id                     INTEGER
        references studies
            on delete cascade,
    observation_unit_db_id       TEXT,
    primary_id                   TEXT,
    secondary_id                 TEXT,
    geo_coordinates              TEXT,
    additional_info              TEXT,
    germplasm_db_id              TEXT,
    germplasm_name               TEXT,
    observation_level            TEXT,
    position_coordinate_x        TEXT,
    position_coordinate_x_type   TEXT,
    position_coordinate_y        TEXT,
    position_coordinate_y_type   TEXT
);

create table observation_units_attributes
(
    internal_id_observation_unit_attribute INTEGER
        primary key autoincrement,
    observation_unit_attribute_name        TEXT,
    study_id                               INTEGER
        references studies
            on delete cascade
);

create table observation_units_values
(
    internal_id_observation_unit_value INTEGER
        primary key autoincrement,
    observation_unit_attribute_db_id   INTEGER
        references observation_units_attributes
            on delete cascade,
    observation_unit_value_name        TEXT,
    observation_unit_id                INTEGER
        references observation_units
            on delete cascade,
    study_id                           INTEGER
        references studies
            on delete cascade
);

create table traits
(
    id                INTEGER
        primary key,
    external_db_id    TEXT,
    trait_data_source TEXT,
    trait             TEXT,
    format            TEXT,
    defaultValue      TEXT,
    minimum           TEXT,
    maximum           TEXT,
    details           TEXT,
    categories        TEXT,
    isVisible         TEXT,
    realPosition      INTEGER
);

create table user_traits
(
    id                INTEGER
        primary key,
    rid               TEXT,
    parent            TEXT,
    trait             TEXT,
    userValue         TEXT,
    timeTaken         TEXT,
    person            TEXT,
    location          TEXT,
    rep               TEXT,
    notes             TEXT,
    exp_id            TEXT,
    observation_db_id TEXT,
    last_synced_time  TEXT
);

CREATE VIEW LocalImageObservations     
            AS SELECT obs.internal_id_observation AS id, 
                obs.value AS value, 
                study.internal_id_study AS study_id
            FROM observations AS obs
            JOIN observation_variables AS vars ON obs.observation_variable_db_id = vars.internal_id_observation_variable 
            JOIN studies AS study ON obs.study_id = study.internal_id_study 
            WHERE (vars.trait_data_source = 'local' OR vars.trait_data_source IS NULL) 
                AND vars.observation_variable_field_book_format = 'photo';

CREATE VIEW NonImageObservations
            AS SELECT obs.internal_id_observation AS id, 
                obs.value AS value, 
                s.internal_id_study AS study_db_id,
                vars.trait_data_source
            FROM observations AS obs, studies AS s
            JOIN observation_variables AS vars ON obs.observation_variable_db_id = vars.internal_id_observation_variable
            JOIN studies ON obs.study_id = studies.internal_id_study
            WHERE vars.observation_variable_field_book_format <> 'photo';

CREATE VIEW RemoteImageObservationsView     
            AS SELECT obs.internal_id_observation AS id, 
                        obs.value AS value, 
                        study.internal_id_study AS study_id,
                        vars.trait_data_source AS trait_data_source,
                        vars.observation_variable_field_book_format
            FROM observations AS obs
            JOIN observation_variables AS vars ON obs.observation_variable_db_id = vars.internal_id_observation_variable 
            JOIN studies AS study ON obs.study_id = study.internal_id_study 
            WHERE study.study_source IS NOT NULL
                AND vars.trait_data_source <> 'local' 
                AND vars.trait_data_source IS NOT NULL
                AND vars.observation_variable_field_book_format = 'photo';

CREATE VIEW VisibleObservationVariable 
AS SELECT internal_id_observation_variable, observation_variable_name, observation_variable_field_book_format, observation_variable_details, default_value, position
FROM observation_variables WHERE visible LIKE "true" ORDER BY position;


