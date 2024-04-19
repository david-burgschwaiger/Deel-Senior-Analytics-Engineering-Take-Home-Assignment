# Deel Senior Analytics Take Home Assignment

## 1a) Preliminary data exploration
In this section I focused on the data quality of the raw data provided. I made sure that the data makes sense and that there's no anomalies in the dataset.

1. Uniqueness & Relationship Tests
- **External_ref Fields**: Both tables have no duplicate or null values.
- **Ref (Acceptance_report Table)**: No duplicate or null values.
- **External_ref Matching**: 1-to-1 relation between acceptance and chargeback.
- **Identical 'External_ref' Values**: Ensuring no IDs are exclusive to either table.

2. Missing Values and Obsolete Fields
- **Data Source**: This field contains always Globalpay (no nulls).
- **Chargeback Rows**: All have accepted status, indicating no refund before successful transaction.
- **Currencies in Rates Fields**: All currencies included, ensuring no breaks in transformations.

3. Outliers
- One transaction has a negative value, potentially indicating a refund.
- Dates are within the first 6 months of 2019, no surprising values.

4. API Documentation
- Documentation from Globepay seems outdated, definitions not reflecting provided examples.
  - **Definition**: “external_ref: The card expiry year. Format: 4 digits. Example: 2020”
  - **Example**: `"external_ref": "evt_1ESgcCOV7fY1ChY1MkZizZt"`
- Checking `external_ref` on the `acceptance_report` table shows changed status and amount.
- We might want to reach out to Globepay to make sure we properly capture the nature of the data (data contract).

## 1b) Summary of your model architecture
In this project, I tried to follow the dbt guidelines as best as I could. As a result, this dbt project emphasises:

1. **Modularization**: I broke down this dbt project into modular pieces such as models, macros, and tests. This makes it easier to manage and maintain the codebase, and encourages reusability.
2. **Layered Architecture**: The models in this dbt project are organised into layers based on their purpose and level of abstraction. The layers I chose are staging, refined, and mart. This separation of concerns helps keep your codebase clean and understandable.
3. **Configure Models**: E.g. Use incremental builds whenever possible to minimize processing time and improve efficiency. Incremental models only rebuild when their source data or underlying logic changes, rather than every time the project is run. For example, our refined model could be a incremental model depending on how much data it concerns
4. **Documentation**: I tried to document models, macros, and datasets thoroughly using dbt's built-in documentation features. This helps ensure that others can understand and use your code effectively.
5. **Testing**: I implemented a couple of generic tests for your models to ensure data quality, integrity, and accuracy. I used the most common built-in testing functionality for common data quality checks like null values, uniqueness, and referential integrity.
7. **Parameterization**: Parameterize your models to make them more flexible and reusable across different environments or use cases. Use variables and configurations to control behavior and settings. Tagging the models in the dbt project is especially useful

## 1c) Lineage Graph
The lineage graph reflects the layered architecture described above. The source data was ingested into Snowflake, and cleaned, tested and aligned in the staging layer. Computations like joins and aggregations happen in the refined layer whereas the mart layer is the final layer that provides the data for the analysts and all consumers of the data.
<img width="1448" alt="image" src="https://github.com/david-burgschwaiger/Deel-Senior-Analytics-Engineering-Take-Home-Assignment/assets/91904138/e1224c6a-3250-4d50-a974-833c3423772e">

## 1d) Tips around macros, data validation, and documentation
1. Macros:
- Use Macros for Reusability: I created one (`return_format_string`) macros for reusable code snippets or logic that are used across multiple models. This promotes code reuse and simplifies maintenance.
- Organize Macros: I recommend to organise macros into logical groups within the macros directory of the dbt project. Using subdirectories to further categorize macros based on their functionality or purpose is super useful.
- Document Macros: I recommend to document macros thoroughly using dbt's built-in documentation features. Including descriptions, usage examples, and parameter details help others understand how to use the macro.

2. Data Validation:
- Implement Data Quality Tests: dbt's built-in testing functionality to implement data quality tests for models is amazing. Be aware of testing, too much tests can overwhelm can the team.
- Automate Testing: Automate the execution of data validation tests as part of dbt workflow. Use scheduling or CI/CD tools to run tests automatically on a regular basis or in response to changes in your data pipeline.
- Custom Tests: Implement custom tests using SQL or Jinja to validate specific data quality requirements or business rules that are not covered by built-in dbt tests.
- Alerting: Set up alerting mechanisms (e.g. on Slack) to notify stakeholders when data validation tests fail. This ensures that data quality issues are addressed promptly and transparently.

3. Documentation:
- Document Models: Document dbt models using dbt's built-in documentation features. Include descriptions, column definitions, data lineage, and other relevant information to help users understand the purpose and structure of each model.
- Use Markdown: I like to write documentation in the Git repos using Markdown syntax to format text, add links, and include images or diagrams. Markdown is supported by dbt's documentation rendering engine and provides a flexible way to create rich documentation.
- Keep Documentation Up-to-date: Regularly review and update documentation to reflect changes in your dbt project, data schema, or business requirements. Outdated documentation can lead to confusion and errors.

## 2a) Acceptance rate over time

The acceptance rate for transactions from Globepay were around 70% in the first half of 2019. The highest acceptance rate was recorded in June (71.6%) while the lowest was observed in April (67.7%).

```sql
select
   date_trunc(month, globalpay_transaction_date) as transaction_month,
   count(case when transaction_state = 'accepted' then globalpay_transaction_id END) as nb_transaction_accepted,
   count(globalpay_transaction_id) as nb_transaction,
   nb_transaction_accepted / nb_transaction
from mart_revenue__card_transaction
group by 1
```

<img width="752" alt="image" src="https://github.com/david-burgschwaiger/Deel-Senior-Analytics-Engineering-Take-Home-Assignment/assets/91904138/cc1e6913-80e3-4c55-9b83-06df305031e0">


## 2b) Countries where the amount of declined transactions went over $25M
The following query shows all countries and their amount of declined transactions over the whole available time frame in the data set.

```sql
select
   country,
   transaction_state,
   SUM(amount_in_usd) as sum_amount_in_usd,
   sun_amount_in_usd >= 25000000 as is_greater_than_25M
from mart_revenue__card_transaction
where transaction_state = 'declined'
group by 1
```

<img width="685" alt="image" src="https://github.com/david-burgschwaiger/Deel-Senior-Analytics-Engineering-Take-Home-Assignment/assets/91904138/ed52f929-2024-45ce-89e0-67b4a0161ac5">


## 2c) Which transactions are missing chargeback data?


