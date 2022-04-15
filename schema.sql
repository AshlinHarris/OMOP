
CREATE TABLE Location (
	location_id bigint PRIMARY KEY,
	address_1 double precision,
 	address_2 double precision,
 	city double precision,
 	state double precision,
 	zip varchar (255),
 	county double precision,
 	location_source_value double precision 
);

CREATE TABLE Care_Site (
	care_site_id bigint PRIMARY KEY,
 	care_site_name varchar (255),
 	place_of_service_concept_id bigint,
 	location_id bigint,
 	care_site_source_value varchar (255),
	FOREIGN KEY (location_id) REFERENCES Location (location_id)
);

CREATE TABLE Person (
	person_id bigint PRIMARY KEY,
 	gender_concept_id bigint,
 	year_of_birth double precision,
 	month_of_birth double precision,
 	day_of_birth double precision,
 	/* birth_datetime timestamp (6), */
 	race_concept_id bigint,
 	ethnicity_concept_id bigint,
 	location_id bigint,
 	provider_id bigint,
 	care_site_id bigint,
 	/* person_source_value double precision, */
 	gender_source_value varchar (255),
 	gender_source_concept_id bigint,
 	race_source_value double precision,
 	race_source_concept_id bigint,
 	/* ethnicity_source_value double precision, */
 	ethnicity_source_concept_id bigint,
	FOREIGN KEY (person_id) REFERENCES Person (person_id),
	FOREIGN KEY (location_id) REFERENCES Location (location_id),
	FOREIGN KEY (care_site_id) REFERENCES Care_Site (care_site_id)
);

CREATE TABLE Condition_Era (
	condition_era_id bigint PRIMARY KEY,
 	person_id bigint,
 	condition_concept_id bigint,
 	condition_era_start_date date,
 	condition_era_end_date date,
 	condition_occurrence_count float (8),
	FOREIGN KEY (person_id) REFERENCES Person (person_id)
);

CREATE TABLE Visit_Occurrence (
	visit_occurrence_id bigint PRIMARY KEY,
 	person_id bigint,
 	visit_concept_id bigint,
 	visit_start_date date,
 	visit_start_datetime timestamp (6),
 	visit_end_date date,
 	visit_end_datetime timestamp (6),
 	visit_type_concept_id bigint,
 	provider_id bigint,
 	care_site_id bigint,
 	visit_source_value varchar (255),
 	visit_source_concept_id bigint,
 	admitting_source_concept_id bigint,
 	admitting_source_value float (8),
 	discharge_to_concept_id bigint,
 	discharge_to_source_value float (8),
 	preceding_visit_occurrence_id bigint,
	FOREIGN KEY (person_id) REFERENCES Person (person_id),
	FOREIGN KEY (care_site_id) REFERENCES Care_Site (care_site_id)
);

CREATE TABLE Condition_Occurrence (
	condition_occurrence_id bigint PRIMARY KEY,
 	person_id bigint,
 	condition_concept_id bigint,
 	condition_start_date date,
 	condition_start_datetime timestamp (6),
 	condition_end_date date,
 	condition_end_datetime timestamp (6),
 	condition_type_concept_id bigint,
 	condition_status_concept_id bigint,
 	stop_reason float (8),
 	/* provider_id bigint, */
 	visit_occurrence_id bigint,
 	visit_detail_id bigint,
 	condition_source_value varchar (255),
	condition_source_concept_id bigint,
 	condition_status_source_value float (8),
	FOREIGN KEY (person_id) REFERENCES Person (person_id),
	FOREIGN KEY (visit_occurrence_id) REFERENCES Visit_Occurrence (visit_occurrence_id)
);

CREATE TABLE Death (
	person_id bigint PRIMARY KEY,
 	death_date date,
 	death_datetime timestamp (6),
 	death_type_concept_id bigint,
 	cause_concept_id bigint,
 	cause_source_value float (8),
 	cause_source_concept_id bigint
);

CREATE TABLE Device_Exposure (
	device_exposure_id bigint PRIMARY KEY,
 	person_id bigint,
 	device_concept_id bigint,
 	device_exposure_start_date date,
 	device_exposure_start_datetime timestamp (6),
 	device_exposure_end_date date,
 	device_exposure_end_datetime timestamp (6),
 	device_type_concept_id bigint,
 	unique_device_id bigint,
 	quantity float (8),
 	provider_id bigint,
 	visit_occurrence_id bigint,
 	visit_detail_id bigint,
 	device_source_value varchar (255),
 	device_source_concept_id bigint,
	FOREIGN KEY (person_id) REFERENCES Person (person_id),
	FOREIGN KEY (visit_occurrence_id) REFERENCES Visit_Occurrence (visit_occurrence_id)
);

CREATE TABLE Drug_Era (
	drug_era_id bigint PRIMARY KEY,
 	person_id bigint,
 	drug_concept_id varchar (255),
 	drug_era_start_date date,
 	drug_era_end_date date,
 	drug_exposure_count float (8),
 	gap_days float (8),
	FOREIGN KEY (person_id) REFERENCES Person (person_id)
);

CREATE TABLE Drug_Exposure (
	drug_exposure_id bigint PRIMARY KEY,
 	person_id bigint,
 	drug_concept_id varchar (255),
 	drug_exposure_start_date date,
 	drug_exposure_start_datetime timestamp (6),
 	drug_exposure_end_date date,
 	drug_exposure_end_datetime timestamp (6),
 	verbatim_end_date date,
 	drug_type_concept_id bigint,
 	stop_reason float (8),
 	refills float (8),
 	quantity float (8),
 	days_supply float (8),
 	sig float (8),
 	route_concept_id bigint,
 	lot_number float (8),
 	provider_id bigint,
 	visit_occurrence_id bigint,
 	visit_detail_id bigint,
 	drug_source_value varchar (255),
 	drug_source_concept_id varchar (255),
 	route_source_value float (8),
 	dose_unit_source_value float (8),
	FOREIGN KEY (person_id) REFERENCES Person (person_id),
	FOREIGN KEY (visit_occurrence_id) REFERENCES Visit_Occurrence (visit_occurrence_id)
);

CREATE TABLE Measurement (
	measurement_id bigint PRIMARY KEY,
 	person_id bigint,
 	measurement_concept_id varchar (255),
	measurement_date varchar (20),
 	measurement_datetime timestamp (6),
 	measurement_time varchar (32),
 	measurement_type_concept_id bigint,
 	operator_concept_id bigint,
 	value_as_number double precision,
 	value_as_concept_id varchar (255),
 	unit_concept_id bigint,
 	range_low double precision,
 	range_high double precision,
 	provider_id bigint,
 	visit_occurrence_id bigint,
 	visit_detail_id bigint,
 	measurement_source_value varchar (255),
 	measurement_source_concept_id varchar (255),
 	unit_source_value varchar (255),
 	value_source_value varchar (255),
	FOREIGN KEY (person_id) REFERENCES Person (person_id),
	FOREIGN KEY (visit_occurrence_id) REFERENCES Visit_Occurrence (visit_occurrence_id)
);

CREATE TABLE Observation_Period (
	obseration_period_id bigint PRIMARY KEY,
 	person_id bigint,
 	observation_period_start_date date,
 	observation_period_end_date date,
 	period_type_concept_id bigint,
	FOREIGN KEY (person_id) REFERENCES Person (person_id)
);

CREATE TABLE Procedure_Occurrence (
	procedure_occurrence_id bigint PRIMARY KEY,
 	person_id bigint,
 	procedure_concept_id varchar (255),
 	procedure_date date,
 	procedure_datetime timestamp (6),
 	procedure_type_concept_id bigint,
 	modifier_concept_id bigint,
 	quantity float (8),
 	provider_id bigint,
 	visit_occurrence_id bigint,
 	visit_detail_id bigint,
 	procedure_source_value varchar (255),
 	procedure_source_concept_id varchar (255),
 	modifier_source_value float (8),
	FOREIGN KEY (person_id) REFERENCES Person (person_id),
	FOREIGN KEY (visit_occurrence_id) REFERENCES Visit_Occurrence (visit_occurrence_id)
);

