{{ config(materialized='table') }}

with base as (
    select
        qualifying_id,
        cast(season as integer) as season,
        cast(round as integer) as round,

        race_name,
        race_date,

        circuit_id,
        circuit_name,
        circuit_locality,
        circuit_country,

        cast(position as integer) as position,
        cast(car_number as integer) as car_number,

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
    from {{ ref('stg_qualifying') }}
),

dim_races as (
    select
        race_key,
        cast(season as integer) as season,
        cast(round as integer) as round
    from {{ ref('dim_races') }}
)

select
    r.race_key,

    b.qualifying_id,
    b.season,
    b.round,

    b.race_name,
    b.race_date,

    b.circuit_id,
    b.circuit_name,
    b.circuit_locality,
    b.circuit_country,

    b.position,
    b.car_number,

    b.driver_id,
    b.driver_permanent_number,
    b.driver_code,
    b.driver_given_name,
    b.driver_family_name,
    b.driver_nationality,
    b.driver_date_of_birth,

    b.constructor_id,
    b.constructor_name,
    b.constructor_nationality,

    b.q1,
    b.q2,
    b.q3,

    b.load_season,
    b.load_date
from base b
left join dim_races r
    on b.season = r.season
   and b.round = r.round
;
