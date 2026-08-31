{{
    config
    (
        materialized='incremental',
        incremental_strategy='append',
        unique_key='Date_Id'

    )

}}

with date_dim as (
select ABS(HASH(f.Date)) AS Date_Id ,
f.date,
f.Isholiday,
f.Insert_date,
CURRENT_TIMESTAMP() AS Update_date

from {{ ref('int_date') }} f

{% if is_incremental() %}
where Insert_date > (select max(Update_date) from {{this}})
{% endif%}

)

select * from date_dim