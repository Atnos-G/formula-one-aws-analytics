{{ config(materialized='table') }}

with src as (
    select
        season,
        round,
        race_name,
        race_date,

        position,
        position_text,
        points,
        grid,
        laps,
        status,

        driver_id,
        constructor_id,

        total_time,
        fastest_lap_rank,
        fastest_lap_time,
        fastest_lap_avg_speed,
        fastest_lap_speed_units,

        load_season,
        load_date
    from {{ ref('stg_results') }}
),

with_keys as (
    select
        -- clé stable de course (doit matcher dim_races)
        {{ dbt_utils.generate_surrogate_key(['season', 'round']) }} as race_key,

        season,
        round,
        race_name,
        race_date,

        driver_id,
        constructor_id,

        position,
        position_text,
        points,
        grid,
        laps,
        status,

        total_time,
        fastest_lap_rank,
        fastest_lap_time,
        fastest_lap_avg_speed,
        fastest_lap_speed_units,

        load_date
    from src
),

dedup as (
    select
        *,
        row_number() over (
            partition by season, round, driver_id
            order by load_date desc
        ) as rn
    from with_keys
)

select
    race_key,

    season,
    round,
    race_name,
    race_date,

    driver_id,
    constructor_id,

    position,
    position_text,
    points,
    grid,
    laps,
    status,

    total_time,
    fastest_lap_rank,
    fastest_lap_time,
    fastest_lap_avg_speed,
    fastest_lap_speed_units

from dedup
where rn = 1
