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
    charindex(tx.billing_currency, tx.exchange_rate_list)
        + len(tx.billing_currency)
        + 2
    as currency_multiplier_start_position, --- determining the starting position of the used currency in the list
    case
        when charindex(',', rates, multiplier_first_position) > 0
        then charindex(',', rates, multiplier_first_position)
        else charindex('}', rates, multiplier_first_position)  -- the last currency do not have a comma
    end as multiplier_last_position, --- determining the last position of the used currency in the list
    substring(
        tx.exchange_rate_list,
        currency_multiplier_start_position,
        currency_multiplier_end_position - currency_multiplier_start_position
    ) as currency_exchange_rate,
    tx.amount / currency_multiplier_value as amount_in_usd,
    tx.amount,

    -- dates
    tx.globepay_transaction_at,
    tx.globepay_transaction_date
from {{ ref("staging_globepay_acceptance") }} as tx
left join
    {{ ref("staging_globepay_chargeback") }} as cb
    on tx.globepay_transaction_id = cb.globepay_transaction_id
