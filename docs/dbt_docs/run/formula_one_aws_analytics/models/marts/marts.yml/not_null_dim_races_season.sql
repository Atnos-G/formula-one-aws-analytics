
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select season
from "AwsDataCatalog"."dbt_marts"."dim_races"
where season is null



  
  
      
    ) dbt_internal_test