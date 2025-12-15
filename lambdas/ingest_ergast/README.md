## Goal
Cloud-native analytics platform on AWS to ingest and analyze Formula 1 data from the Ergast API.

## Target architecture
Ergast API -> Lambda (ingestion) -> S3 (raw) -> dbt/Glue (transform) -> Athena/Redshift Serverless -> BI

## Data model (planned)
Staging: stg_drivers, stg_races, stg_results, stg_constructors
Marts: mart_driver_season_stats, mart_constructor_season_stats, mart_race_results

## Project structure
- lambdas/ : ingestion code
- dbt/     : transformations (staging -> marts)
- infra/   : IaC (later)
- docs/    : architecture + decisions
