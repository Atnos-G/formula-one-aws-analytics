
    
    

select
    qualifying_id as unique_field,
    count(*) as n_records

from "AwsDataCatalog"."dbt_marts"."fct_qualifying"
where qualifying_id is not null
group by qualifying_id
having count(*) > 1


