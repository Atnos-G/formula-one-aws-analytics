

with src as (
    select
        payload,
        season as load_season,
        load_date
    from "AwsDataCatalog"."formula_one_raw"."raw_qualifying_json"
),

races as (
    select
        load_season,
        load_date,
        race
    from src
    cross join unnest(
        cast(json_extract(payload, '$.MRData.RaceTable.Races') as array(json))
    ) as t(race)
),

qual_rows as (
    select
        load_season,
        load_date,

        cast(json_extract_scalar(race, '$.season') as integer) as season,
        cast(json_extract_scalar(race, '$.round') as integer) as round,
        json_extract_scalar(race, '$.raceName') as race_name,
        date_parse(json_extract_scalar(race, '$.date'), '%Y-%m-%d') as race_date,

        json_extract_scalar(race, '$.Circuit.circuitId') as circuit_id,
        json_extract_scalar(race, '$.Circuit.circuitName') as circuit_name,
        json_extract_scalar(race, '$.Circuit.Location.locality') as circuit_locality,
        json_extract_scalar(race, '$.Circuit.Location.country') as circuit_country,

        cast(json_extract_scalar(qr, '$.position') as integer) as position,
        cast(json_extract_scalar(qr, '$.number') as integer) as car_number,

        json_extract_scalar(qr, '$.Driver.driverId') as driver_id,
        cast(json_extract_scalar(qr, '$.Driver.permanentNumber') as integer) as driver_permanent_number,
        json_extract_scalar(qr, '$.Driver.code') as driver_code,
        json_extract_scalar(qr, '$.Driver.givenName') as driver_given_name,
        json_extract_scalar(qr, '$.Driver.familyName') as driver_family_name,
        json_extract_scalar(qr, '$.Driver.nationality') as driver_nationality,
        date_parse(json_extract_scalar(qr, '$.Driver.dateOfBirth'), '%Y-%m-%d') as driver_date_of_birth,

        json_extract_scalar(qr, '$.Constructor.constructorId') as constructor_id,
        json_extract_scalar(qr, '$.Constructor.name') as constructor_name,
        json_extract_scalar(qr, '$.Constructor.nationality') as constructor_nationality,

        json_extract_scalar(qr, '$.Q1') as q1,
        json_extract_scalar(qr, '$.Q2') as q2,
        json_extract_scalar(qr, '$.Q3') as q3
    from races
    cross join unnest(
        cast(json_extract(race, '$.QualifyingResults') as array(json))
    ) as t(qr)
)

select
    season,
    round,
    race_name,
    race_date,
    circuit_id,
    circuit_name,
    circuit_locality,
    circuit_country,

    -- ✅ clé technique simple et valide SQL
    concat(
        cast(season as varchar),
        '-',
        cast(round as varchar),
        '-',
        driver_id
    ) as qualifying_id,

    position,
    car_number,

    driver_id,
    driver_permanent_number,
    driver_code,
    driver_given_name,
    driver_family_name,
    driver_nationality,
    driver_date_of_birth,

    constructor_id,
    constructor_name,
    constructor_nationality,

    q1,
    q2,
    q3,

    load_season,
    load_date
from qual_rows;