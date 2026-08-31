{{
    config
    (
        materialized='incremental',
        incremental_strategy='append',
        unique_key='Date_Id'

    )

}}

with date_dim as (
f.Date_Id ,
f.date,
f.Isholiday,
{% if is_incremental() %}

    Insert_date,
{% else %}
    current_timestamp() as Insert_date,
{% endif %}

current_timestamp() as Update_date
from {{ ref('int_date') }} f

{% if is_incremental() %}
where Insert_date > (select max(Update_date) from {{this}})
{% endif%}

)

select * from date_dim