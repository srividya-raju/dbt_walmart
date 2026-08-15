select * 
from {{ source('bronze_layer','fact') }}