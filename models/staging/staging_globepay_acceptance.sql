select
    -- keys
    external_ref as globepay_transaction_id,
    ref as globepay_transaction_event_id,

    -- properties
    lower(source) as transaction_source,
    lower(country) as billing_country,
    lower(state) as transaction_state,
    cvv_provided as is_cvv_provided,

    -- metadata
    lower(rates) as exchange_rate_list,
    lower(currency) as billing_currency,
    amount,

    -- dates
    date_time as globepay_transaction_at,
    to_date(date_time) as globepay_transaction_date
from {{ source("globepay", "acceptance") }}
