# Deel Senior Analytics Take Home Assignment

## Data Exploration

### Unicity Tests & Missing Values
- **External_ref Fields**: Both tables have no duplicate or null values.
- **Ref (Acceptance_report Table)**: No duplicate or null values.
- **External_ref Matching**: 1-to-1 relation between tables.
- **Identical 'External_ref' Values**: Ensuring no IDs are exclusive to either table.

### Accepted Value Tests
- **Data Source**: Always Globalpay (no nulls).
- **Chargeback Rows**: All have accepted status, indicating no refund before successful transaction.
- **Currencies in Rates Fields**: All currencies included, ensuring no breaks in transformations.

## Outliers
- One transaction has a negative value, potentially indicating a refund.
- Dates are within the first 6 months of 2019, no surprising values.

## API Documentation
- Documentation seems outdated, definitions not reflecting provided examples.
  - **Definition**: “external_ref: The card expiry year. Format: 4 digits. Example: 2020”
  - **Example**: `"external_ref": "evt_1ESgcCOV7fY1ChY1MkZizZt"`
- Checking `external_ref` on the `acceptance_report` table shows changed status and amount.

## Query Result
- Assumption: The table may not store history but updates rows' results. Consideration for data modeling.
  ```json
  {
    "state": "ACCEPTED",
    "chargeback": "FALSE",
    "amount": 1000
  }
