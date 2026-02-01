
    
    

with child as (
    select pole_constructor_id as from_field
    from "AwsDataCatalog"."dbt_marts"."ana_qualifying_pole"
    where pole_constructor_id is not null
),

parent as (
    select constructor_id as to_field
    from "AwsDataCatalog"."dbt_marts"."dim_constructors"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


