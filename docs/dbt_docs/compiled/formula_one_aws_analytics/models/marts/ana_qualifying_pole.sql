

with q as (
    select
        race_key,
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

        q1, q2, q3,
        position
    from "AwsDataCatalog"."dbt_marts"."fct_qualifying"
),

pole_per_race as (
    select
        race_key,
        season,
        round,
        race_name,
        race_date,
        circuit_id,
        circuit_name,

        driver_id as pole_driver_id,
        driver_given_name as pole_driver_given_name,
        driver_family_name as pole_driver_family_name,

        constructor_id as pole_constructor_id,
        constructor_name as pole_constructor_name,

        q1, q2, q3
    from q
    where position = 1
),

with_counts as (
    select
        p.*,

        count(*) over (partition by pole_driver_id) as driver_poles_total,
        count(*) over (partition by pole_constructor_id) as constructor_poles_total
    from pole_per_race p
)

select * from with_counts
;