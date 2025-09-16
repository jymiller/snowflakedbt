{% test is_positive_amount(model, column_name) %}
-- Flags rows that are NULL, non-numeric, or <= 0
with cte as (
  select
    {{ column_name }} as val,
    try_to_decimal(to_varchar({{ column_name }}), 38, 9) as val_num
  from {{ model }}
)
select *
from cte
where val is null
   or val_num is null
   or val_num <= 0
{% endtest %}