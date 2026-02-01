

with src as (
    select
        payload,
        season as load_season,
        load_date
    from "AwsDataCatalog"."formula_one_raw"."raw_races_json"
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
)

select
    cast(json_extract_scalar(race, '$.season') as integer)            as season,
    cast(json_extract_scalar(race, '$.round') as integer)             as round,
    json_extract_scalar(race, '$.raceName')                           as race_name,
    date_parse(json_extract_scalar(race, '$.date'), '%Y-%m-%d')        as race_date,
    json_extract_scalar(race, '$.url')                                as race_url,

    -- circuit
    json_extract_scalar(race, '$.Circuit.circuitId')                  as circuit_id,
    json_extract_scalar(race, '$.Circuit.circuitName')                as circuit_name,
    json_extract_scalar(race, '$.Circuit.Location.locality')          as circuit_locality,
    json_extract_scalar(race, '$.Circuit.Location.country')           as circuit_country,
    cast(json_extract_scalar(race, '$.Circuit.Location.lat') as double) as circuit_lat,
    cast(json_extract_scalar(race, '$.Circuit.Location.long') as double) as circuit_lng,

    load_season,
    load_date
from races;