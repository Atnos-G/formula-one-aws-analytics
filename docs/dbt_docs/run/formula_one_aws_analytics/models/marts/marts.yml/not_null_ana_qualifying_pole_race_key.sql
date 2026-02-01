
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select race_key
from "AwsDataCatalog"."dbt_marts"."ana_qualifying_pole"
where race_key is null



  
  
      
    ) dbt_internal_test