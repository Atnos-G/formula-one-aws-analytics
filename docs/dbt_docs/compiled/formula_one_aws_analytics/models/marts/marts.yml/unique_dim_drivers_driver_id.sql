
    
    

select
    driver_id as unique_field,
    count(*) as n_records

from "AwsDataCatalog"."dbt_marts"."dim_drivers"
where driver_id is not null
group by driver_id
having count(*) > 1


