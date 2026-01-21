{{ config(materialized='view') }}

with src as (
    select
        payload,
        season as load_season,
        load_date
    from {{ source('formula_one_raw', 'raw_results_json') }}
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

race_results as (
    select
        load_season,
        load_date,
        cast(json_extract_scalar(race, '$.season') as integer)     as season,
        cast(json_extract_scalar(race, '$.round') as integer)      as round,
        json_extract_scalar(race, '$.raceName')                    as race_name,
        date_parse(json_extract_scalar(race, '$.date'), '%Y-%m-%d') as race_date,
        res
    from races
    cross join unnest(
        cast(json_extract(race, '$.Results') as array(json))
    ) as t(res)
)

select
    season,
    round,
    race_name,
    race_date,

    -- résultat (ligne)
    cast(json_extract_scalar(res, '$.position') as integer)        as position,
    json_extract_scalar(res, '$.positionText')                     as position_text,
    cast(json_extract_scalar(res, '$.points') as double)           as points,
    cast(json_extract_scalar(res, '$.grid') as integer)            as grid,
    cast(json_extract_scalar(res, '$.laps') as integer)            as laps,
    json_extract_scalar(res, '$.status')                           as status,

    -- driver
    json_extract_scalar(res, '$.Driver.driverId')                  as driver_id,

    -- constructor (1er constructeur)
    json_extract_scalar(res, '$.Constructor.constructorId')        as constructor_id,

    -- timings (peuvent être null)
    json_extract_scalar(res, '$.Time.time')                        as total_time,
    cast(json_extract_scalar(res, '$.FastestLap.rank') as integer)  as fastest_lap_rank,
    json_extract_scalar(res, '$.FastestLap.Time.time')             as fastest_lap_time,
    cast(json_extract_scalar(res, '$.FastestLap.AverageSpeed.speed') as double) as fastest_lap_avg_speed,
    json_extract_scalar(res, '$.FastestLap.AverageSpeed.units')    as fastest_lap_speed_units,

    load_season,
    load_date
from race_results;
