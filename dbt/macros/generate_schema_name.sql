{% macro generate_schema_name(custom_schema_name, node) -%}
    {#-
      Objectif : éviter les schémas composites du type dbt_staging_dbt_marts.
      Règle :
      - si +schema est défini -> on l’utilise tel quel (dbt_marts, dbt_staging)
      - sinon -> on garde target.schema
    -#}

    {%- if custom_schema_name is none -%}
        {{ target.schema }}
    {%- else -%}
        {{ custom_schema_name | trim }}
    {%- endif -%}
{%- endmacro %}
