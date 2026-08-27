SELECT *
FROM {{ source('raw', 'fact') }} 