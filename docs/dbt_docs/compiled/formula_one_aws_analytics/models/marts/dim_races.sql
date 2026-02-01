

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
    from "AwsDataCatalog"."dbt_staging"."stg_races"
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
    lower(to_hex(md5(to_utf8(cast(coalesce(cast(season as VARCHAR), '_dbt_utils_surrogate_key_null_') || '-' || coalesce(cast(round as VARCHAR), '_dbt_utils_surrogate_key_null_') as varchar))))) as race_key,

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