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

