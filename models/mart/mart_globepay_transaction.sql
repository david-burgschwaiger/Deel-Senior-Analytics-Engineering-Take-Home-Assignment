select
    globepay_transaction_id,
    globepay_transaction_event_id,

    -- properties
    transaction_source,
    billing_country,
    transaction_state,
    is_cvv_provided,
    is_chargedback,

    -- metadata
    billing_currency,
    currency_exchange_rate,
    amount_in_usd,
    amount,

    -- dates
    globepay_transaction_at,
    globepay_transaction_date
from {{ ref("refined_globepay_transaction") }}
