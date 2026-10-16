{{
    config(
        materialized='incremental',
        incremental_strategy = 'delete+insert',
        unique_key='store_ID'
    )
}}

with src as (

    select
        store_ID,
        store,
        dept,
        type,
        size,
        create_time,
        INSERT_DATE
    from {{ ref('int_store') }} f

    -- one row per date_id: keep the latest version
    qualify row_number() over (
        partition by store_ID
        order by f.create_time desc
    ) = 1

),

final as (

    select
        store_ID,
        store,
        dept,
        type,
        size,
        create_time,
        INSERT_DATE
    from src s

    {% if is_incremental() %}
    where create_time > (select max(insert_date) from {{this}})
    {% endif %}

)

select * from final