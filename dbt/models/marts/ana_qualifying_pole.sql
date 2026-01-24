{{ config(materialized='view') }}

with poles as (
    select
        season,
        round,
        race_name,
        race_date,
        circuit_id,
        circuit_name,

        driver_id,
        driver_given_name,
        driver_family_name,
        constructor_id,
        constructor_name,

        q1, q2, q3
    from {{ ref('fct_qualifying') }}
    where position = 1
),

driver_poles as (
    select
        driver_id,
        driver_given_name,
        driver_family_name,
        count(*) as pole_count
    from poles
    group by 1,2,3
),

constructor_poles as (
    select
        constructor_id,
        constructor_name,
        count(*) as pole_count
    from poles
    group by 1,2
)

select
    p.*,
    dp.pole_count as driver_poles_total,
    cp.pole_count as constructor_poles_total
from poles p
left join driver_poles dp
    on p.driver_id = dp.driver_id
left join constructor_poles cp
    on p.constructor_id = cp.constructor_id;
