
    
    

with child as (
    select driver_id as from_field
    from "AwsDataCatalog"."dbt_marts"."fct_results"
    where driver_id is not null
),

parent as (
    select driver_id as to_field
    from "AwsDataCatalog"."dbt_marts"."dim_drivers"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


