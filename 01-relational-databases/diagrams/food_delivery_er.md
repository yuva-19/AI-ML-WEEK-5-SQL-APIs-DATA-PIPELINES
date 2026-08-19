CUSTOMER
---------
customer_id (PK)
name
city

       1
       │
       │ places
       │
       N
       │
       ▼

ORDER
---------
order_id (PK)
customer_id (FK)
amount