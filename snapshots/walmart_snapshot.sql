{% snapshot fact_snapshot %}

{{
    config(
        strategy='check',
        unique_key = 'store',
        check_cols = ['date','temperature','fuel_price','unemployment','cpi','markdown1','markdown2','markdown3','markdown4','markdown5']
    )
}}

select * from {{  ref('stg_fact') }}




{% endsnapshot %}