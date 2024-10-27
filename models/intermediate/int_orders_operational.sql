SELECT
o.orders_id
,o.date_date
,o.revenue
,o.margin
,o.purchase_cost
,s.shipping_fee
,s.logcost
,s.ship_cost
,o.order_quantity
,ROUND(
    SAFE_CAST(o.margin AS FLOAT64)+
    SAFE_CAST(s.shipping_fee AS FLOAT64)-
    (SAFE_CAST(s.logcost AS FLOAT64) + SAFE_CAST(s.ship_cost AS FLOAT64)),2
) AS operational_margin
FROM {{ref("int_orders_margin")}} o
LEFT JOIN {{ref("stg_raw__ship")}} s
  USING(orders_id)
ORDER BY orders_id DESC