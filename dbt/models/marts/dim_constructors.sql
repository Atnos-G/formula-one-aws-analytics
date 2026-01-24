{{ config(materialized='table') }}

with src as (
    select
        constructor_id,
        constructor_name,
        constructor_nationality,
        constructor_url,
        load_date
    from {{ ref('stg_constructors') }}
),

dedup as (
    select
        *,
        row_number() over (
            partition by constructor_id 
            order by load_date desc
            ) as rn
    from src
)

select
    constructor_id,
    constructor_name,
    constructor_nationality,
    constructor_url
from dedup
where rn = 1
