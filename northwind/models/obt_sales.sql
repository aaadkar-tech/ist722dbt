with f_sales as (
    select * from {{ ref('fact_sales') }}
),
d_customer as (
    select * from {{ ref('dim_customer') }}
),
d_employee as (
    select * from {{ ref('dim_employee') }}
),
d_product as (
    select * from {{ ref('dim_product') }}
),
d_date as (
    select * from {{ ref('dim_date') }}
)

select
    f.customerkey,
    f.employeekey,
    f.productkey,
    f.orderdatekey,
    f.orderid,
    f.quantity,
    f.unitprice as order_unitprice,
    f.discount,
    f.extendedprice,
    d_customer.customerid,
    d_customer.companyname,
    d_customer.contactname,
    d_customer.contacttitle,
    d_customer.address,
    d_customer.city,
    d_customer.region,
    d_customer.postalcode,
    d_customer.country,
    d_customer.phone,
    d_customer.fax,
    d_employee.employeeid,
    d_employee.employeeenamelastfirst,
    d_employee.employeenamefirstlast,
    d_employee.employeetitle,
    d_employee.supervisornamelastfirst,
    d_employee.supervisornamefirstlast,
    d_product.productid,
    d_product.productname,
    d_product.quantityperunit,
    d_product.unitprice as product_unitprice,
    d_product.categoryname,
    d_product.suppliername,
    d_date.datekey,
    d_date.date,
    d_date.year,
    d_date.month,
    d_date.quarter,
    d_date.dayname,
    d_date.monthname
from f_sales as f
    left join d_customer on f.customerkey = d_customer.customerkey
    left join d_employee on f.employeekey = d_employee.employeekey
    left join d_product on f.productkey = d_product.productkey
    left join d_date on f.orderdatekey = d_date.datekey