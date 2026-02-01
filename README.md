# Formula One — AWS Analytics Platform (Serverless)

Cloud-native data analytics project on AWS.  
The platform ingests Formula 1 data from the Ergast API, stores raw data in S3, transforms it using dbt on Athena, and exposes analytics-ready tables via the Glue Data Catalog.

---

## Goals
- Build a serverless, cloud-native data platform (S3, Athena, Glue, dbt)
- Apply Data Engineering best practices: modeling, testing, documentation, CI
- Serve as a learning and portfolio project aligned with AWS Solution Architect Associate topics

---

## High-level architecture
Ergast API  
→ AWS Lambda (ingestion)  
→ Amazon S3 (raw zone)  
→ dbt (SQL transformations) on Amazon Athena  
→ Amazon S3 (analytics zone) + AWS Glue Data Catalog  
→ (Optional BI layer)

### Data zones (S3)
- `raw/` : raw JSON data as received from the API
- `analytics/` : curated tables produced by dbt (staging + marts)

---

## Data model (dbt)

### Staging models
- `stg_drivers`
- `stg_constructors`
- `stg_races`
- `stg_qualifying`
- `stg_results`

### Mart models

**Dimensions**
- `dim_drivers`
- `dim_constructors`
- `dim_races`

**Facts**
- `fct_qualifying`
- `fct_results`

**Analytics**
- `ana_qualifying_pole` — pole position per race

---

## Repository structure
- `lambdas/` : ingestion logic (API → S3)
- `dbt/` : dbt project (models, tests, documentation)
- `infra/` : infrastructure as code (optional / future work)
- `docs/` :
  - `architecture.md` — architectural overview
  - `decision.md` — technical decisions and trade-offs

---

## How to run the project (local)

### Prerequisites
- Python + virtual environment
- dbt with Athena adapter
- AWS credentials with access to S3, Athena and Glue

### Run dbt
```bash
dbt deps --profiles-dir ~/.dbt
dbt build --profiles-dir ~/.dbt
dbt docs generate --profiles-dir ~/.dbt
```

Querying data:
 - Use the Glue database created by dbt
 - Query marts tables (dim_*, fct_*) in Athena for analytics use-cases

Testing & data quality

dbt tests:
 - not_null
 - unique
 - relationships
 - composite keys on fact tables

Model-level assumptions documented in schema YAML files

CI:
 - GitHub Actions pipeline running dbt build
 - Lightweight quality gate on pull requests

Scope
Included:
 - Serverless ingestion to S3
 - SQL-based transformations with dbt on Athena
 - Data quality tests and documentation
 - Glue Data Catalog integration

Not included (by design):
 - BI dashboards (QuickSight not activated in current AWS free-tier context)

Key technical decisions:
 - Amazon Athena chosen as a fully serverless analytics engine
 - AWS Glue Data Catalog used as the central metadata layer
 - dbt used for SQL-first transformations, testing and documentation

Details are available in docs/architecture.md and docs/decision.md.

Documentation:
 - dbtdocs generated: see docs/dbt_docs/index.html

Credits:
 - Data source: Ergast API
 - Dataset inspired by Kaggle Formula 1 datasets