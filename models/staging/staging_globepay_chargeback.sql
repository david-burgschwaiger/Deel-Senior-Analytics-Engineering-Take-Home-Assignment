select
    -- keys
    external_ref AS globalpay_transaction_id,  

    -- dimensions
    lower(source) AS chargeback_source, 
    chargeback AS is_chargedback
from {{ source("globepay", "chargeback") }}
