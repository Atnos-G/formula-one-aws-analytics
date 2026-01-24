{{ config(materialized='table') }}

with base as (
    select * from {{ ref('stg_qualifying') }}
),

final as (
    select
        -- id stable
        lower(
          to_hex(
            md5(
              to_utf8(
                cast(season as varchar) || '-' ||
                cast(round as varchar) || '-' ||
                driver_id
              )
            )
          )
        ) as qualifying_id,

        season,
        round,
        race_name,
        race_date,
        circuit_id,
        circuit_name,
        circuit_locality,
        circuit_country,

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
    from base
)

select * from final;
