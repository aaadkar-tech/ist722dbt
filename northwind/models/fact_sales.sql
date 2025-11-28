with stg_orders as (
    select
        OrderID,  
        {{ dbt_utils.generate_surrogate_key(['employeeid']) }} as employeekey,
        {{ dbt_utils.generate_surrogate_key(['customerid']) }} as customerkey,
        replace(to_date(orderdate)::varchar,'-','')::int as orderdatekey
    from {{source('northwind','Orders')}}
),
stg_order_details as (
    select
        orderid,
        {{ dbt_utils.generate_surrogate_key(['productid']) }} as productkey,
        unitprice,
        quantity,
        discount,
        quantity * unitprice * (1 - discount) as extendedprice
    from {{source('northwind','Order_Details')}}
)

select
    o.customerkey,
    o.employeekey,
    od.productkey,
    o.orderdatekey,
    o.orderid,
    od.quantity,
    od.unitprice,
    od.discount,
    od.extendedprice
from stg_orders o
    join stg_order_details od on o.orderid = od.orderid