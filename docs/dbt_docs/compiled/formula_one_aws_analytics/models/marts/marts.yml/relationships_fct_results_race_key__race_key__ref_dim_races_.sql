
    
    

with child as (
    select race_key as from_field
    from "AwsDataCatalog"."dbt_marts"."fct_results"
    where race_key is not null
),

parent as (
    select race_key as to_field
    from "AwsDataCatalog"."dbt_marts"."dim_races"
)

select
    from_field

from child
left join parent
    on child.from_field = parent.to_field

where parent.to_field is null


