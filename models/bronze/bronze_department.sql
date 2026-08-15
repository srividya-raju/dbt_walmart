select * 
from {{ source('bronze_layer','department') }}