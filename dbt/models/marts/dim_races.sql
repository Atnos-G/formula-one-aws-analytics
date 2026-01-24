{{ config(materialized='table') }}

with src as (
    select
        season,
        round,
        race_name,
        race_date,
        race_url,
        circuit_id,
        circuit_name,
        circuit_locality,
        circuit_country,
        circuit_lat,
        circuit_lng,
        load_date
    from {{ ref('stg_races') }}
),

dedup as (
    select
        *,
        row_number() over (
            partition by season, round 
            order by load_date desc, race_date desc
            ) as rn
    from src
)

select
    -- Clé analytique stable (même si race_id change / si on veut ignorer race_id côté BI)
    {{ dbt_utils.generate_surrogate_key(['season', 'round']) }} as race_key,

    season,
    round,
    race_name,
    race_date,
    race_url,
    circuit_id,
    circuit_name,
    circuit_locality,
    circuit_country,
    circuit_lat,
    circuit_lng
from dedup
where rn = 1
