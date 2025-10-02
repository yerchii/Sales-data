with base as (
    select
        "Reference ID" as reference_id,
        "Product Name" as product_name,
        "Sales Agent Name" as sales_agent_name,
        "Country" as country,
        "Source" as source,
        "Campaign Name" as campaign_name,
        "Total Amount ($)" as total_amount,
        "Discount Amount ($)" as discount_amount,
        "Number Of Rebills" as number_of_rebills,
        "Returned Amount ($)" as returned_amount,
        "Total Rebill Amount" as total_rebill_amount,
        "Order Date Kyiv" as order_date_kyiv,
        "Return Date Kyiv" as return_date_kyiv
    from {{ ref('sales_data') }}
),

aggregated as (
    select
        reference_id,
        max(product_name) as product_name,

        -- объединяем имена агентов через запятую, игнорируя null или 'N/A'
        string_agg(distinct sales_agent_name, ', ') filter (where sales_agent_name is not null and sales_agent_name <> 'N/A') as sales_agents,

        max(coalesce(country, 'N/A')) as country,
        max(coalesce(source, 'N/A')) as source,
        max(coalesce(campaign_name, 'N/A')) as campaign_name,

        -- финансы
        sum(coalesce(total_amount,0) + coalesce(total_rebill_amount,0) - coalesce(returned_amount,0)) as revenue_total,
        sum(coalesce(total_rebill_amount,0)) as revenue_rebill,
        max(coalesce(number_of_rebills,0)) as number_of_rebills,
        sum(coalesce(discount_amount,0)) as discount_amount,
        sum(coalesce(returned_amount,0)) as returned_amount,

        -- даты
        min(order_date_kyiv) as order_date_kyiv,
        min(return_date_kyiv) as return_date_kyiv
    from base
    group by reference_id
)

select
    reference_id,
    product_name,
    sales_agents,
    country,
    source,
    campaign_name,
    revenue_total,
    revenue_rebill,
    number_of_rebills,
    discount_amount,
    returned_amount,

    -- даты в разных таймзонах
    order_date_kyiv,
    order_date_kyiv at time zone 'Europe/Kiev' at time zone 'UTC' as order_date_utc,
    order_date_kyiv at time zone 'Europe/Kiev' at time zone 'America/New_York' as order_date_ny,

    return_date_kyiv,
    return_date_kyiv at time zone 'Europe/Kiev' at time zone 'UTC' as return_date_utc,
    return_date_kyiv at time zone 'Europe/Kiev' at time zone 'America/New_York' as return_date_ny,

    -- разница дней между возвратом и покупкой
    case when return_date_kyiv is not null
         then date(return_date_kyiv) - date(order_date_kyiv)
         else null end as days_diff
from aggregated
