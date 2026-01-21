{{ config(materialized='view') }}

with src as (
    select
        payload,
        season as load_season,
        load_date
    from {{ source('formula_one_raw', 'raw_drivers_json') }}
),

drivers as (
    select
        load_season,
        load_date,
        d
    from src
    cross join unnest(
        cast(json_extract(payload, '$.MRData.DriverTable.Drivers') as array(json))
    ) as t(d)
)

select
    json_extract_scalar(d, '$.driverId')                                as driver_id,
    cast(json_extract_scalar(d, '$.permanentNumber') as integer)        as driver_permanent_number,
    json_extract_scalar(d, '$.code')                                    as driver_code,
    json_extract_scalar(d, '$.givenName')                               as driver_given_name,
    json_extract_scalar(d, '$.familyName')                              as driver_family_name,
    date_parse(json_extract_scalar(d, '$.dateOfBirth'), '%Y-%m-%d')      as driver_date_of_birth,
    json_extract_scalar(d, '$.nationality')                             as driver_nationality,
    json_extract_scalar(d, '$.url')                                     as driver_url,

    load_season,
    load_date
from drivers;
