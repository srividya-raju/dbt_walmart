select * 
from {{ source('bronze_layer','stores') }}