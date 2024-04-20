select
    -- keys
    tx.globepay_transaction_id,
    tx.globepay_transaction_event_id,

    -- properties
    tx.transaction_source,
    tx.billing_country,
    tx.transaction_state,
    tx.is_cvv_provided,
    cb.is_chargedback,

    -- metadata
    tx.exchange_rate_list,
    tx.billing_currency,
    json_extract_path_text(parse_json(rates), currency) as currency_exchange_rate,
    tx.amount / currency_multiplier_value as amount_in_usd,
    tx.amount,

    -- dates
    tx.globepay_transaction_at,
    tx.globepay_transaction_date
from {{ ref("staging_globepay_acceptance") }} as tx
left join
    {{ ref("staging_globepay_chargeback") }} as cb
    on tx.globepay_transaction_id = cb.globepay_transaction_id
