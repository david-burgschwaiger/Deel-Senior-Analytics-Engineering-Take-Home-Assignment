# Deel Senior Analytics Take Home Assignment

## Preliminary data exploration
In this section I looked at the data from two perspectives. First I made sure that the data makes sense and that there's no anomalies in the dataset (i.e. Data Quality Checks). Afterwards, I had a first look at the data itself and look at some descriptive stats of the raw data.

### Data Quality
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

### Initial Data Exploration
sdfas

## Summary of your model architecture
In this project, I tried to follow the dbt guidelines as best as I could. As a result, this dbt project emphasises:

1. **Modularization**: Break down your dbt project into modular pieces such as models, macros, tests, and seeds. This makes it easier to manage and maintain your codebase, and encourages reusability.
2. **Layered Architecture**: Organize your models into layers based on their purpose and level of abstraction. Common layers include staging, transformations, dimensions, and facts. This separation of concerns helps keep your codebase clean and understandable.
3. **Incremental Builds**: Use incremental builds whenever possible to minimize processing time and improve efficiency. Incremental models only rebuild when their source data or underlying logic changes, rather than every time the project is run.
4. **Documentation**: Document your models, macros, and datasets thoroughly using dbt's built-in documentation features. This helps ensure that others (and future you) can understand and use your code effectively.
5. **Version Control**: Use version control (such as Git) to manage changes to your dbt project. This allows you to track changes over time, collaborate with others, and revert to previous versions if needed.
6. **Testing**: Implement tests for your models to ensure data quality, integrity, and accuracy. dbt provides built-in testing functionality for common data quality checks like null values, uniqueness, and referential integrity.
7. **Parameterization**: Parameterize your models to make them more flexible and reusable across different environments or use cases. Use variables and configurations to control behavior and settings.

## Lineage Graph
<img width="1084" alt="image" src="https://github.com/david-burgschwaiger/Deel-Senior-Analytics-Engineering-Take-Home-Assignment/assets/91904138/875a9003-e283-4bf3-b2bb-762e2b6fd006">

## Tips around macros, data validation, and documentation
1. Macros:
- Use Macros for Reusability: Create macros for reusable code snippets or logic that are used across multiple models. This promotes code reuse and simplifies maintenance.
- Organize Macros: Organize your macros into logical groups within the macros directory of your dbt project. Use subdirectories to further categorize macros based on their functionality or purpose.
- Version Control Macros: Version control your macros along with the rest of your dbt project. This ensures that changes to macros are tracked and can be reverted if necessary.
- Document Macros: Document your macros thoroughly using dbt's built-in documentation features. Include descriptions, usage examples, and parameter details to help users understand how to use the macro.

2. Data Validation:
- Implement Data Quality Tests: Use dbt's built-in testing functionality to implement data quality tests for your models. Include tests for null values, uniqueness, referential integrity, and other data quality checks.
- Automate Testing: Automate the execution of data validation tests as part of your dbt workflow. Use scheduling or CI/CD tools to run tests automatically on a regular basis or in response to changes in your data pipeline.
- Custom Tests: Implement custom tests using SQL or Jinja to validate specific data quality requirements or business rules that are not covered by built-in dbt tests.
- Alerting: Set up alerting mechanisms to notify stakeholders when data validation tests fail. This ensures that data quality issues are addressed promptly and transparently.

3. Documentation:
- Document Models: Document your dbt models using dbt's built-in documentation features. Include descriptions, column definitions, data lineage, and other relevant information to help users understand the purpose and structure of each model.
- Use Markdown: Write documentation using Markdown syntax to format text, add links, and include images or diagrams. Markdown is supported by dbt's documentation rendering engine and provides a flexible way to create rich documentation.
- Keep Documentation Up-to-date: Regularly review and update documentation to reflect changes in your dbt project, data schema, or business requirements. Outdated documentation can lead to confusion and errors.
- Document Macros and Tests: Document macros, tests, and other code artifacts in your dbt project to provide context and guidance for users. Include explanations, usage examples, and parameter descriptions to facilitate understanding and adoption.
