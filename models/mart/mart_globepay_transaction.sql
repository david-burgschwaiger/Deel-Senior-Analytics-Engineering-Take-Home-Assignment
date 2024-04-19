select
    globalpay_transaction_id,
    globalpay_transaction_event_id,

    -- properties
    transaction_source,
    billing_country,
    transaction_state,
    is_cvv_provided,
    is_chargedback,

    -- metadata
    exchange_rate_list,
    billing_currency,
    currency_exchange_rate,
    amount_in_usd,
    amount,

    -- dates
    globalpay_transaction_at,
    globalpay_transaction_date
from {{ ref("refined_globepay_transaction") }}
