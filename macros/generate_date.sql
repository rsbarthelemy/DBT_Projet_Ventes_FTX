{% macro generate_series(start_date, end_date) %}
    with recursive series as (
        select cast({{ start_date }} as date) as date
        union all
        select date + 1
        from series
        where date + 1 <= {{ end_date }}
    )
    select date from series
{% endmacro %}
