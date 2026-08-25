# Q1 — Read the API Specification 🟡
# Imagine the documentation says:
# Base URL:
# https://api.example.com

# Endpoint:
# GET /products/{product_id}

# Path Parameter:
# product_id → Required

# Authentication:
# X-API-Key header

# Response:
# {
#     "product_id": 101,
#     "product_name": "Laptop",
#     "price": 65000
# }

import requests

product_id  = 5

api_key = '1234'

headers = {
    "X-API-Key" : api_key
}
try:

    response = requests.get(
        f'https://api.example.com/products/{product_id}',
        headers= headers,
        timeout= 5
    )
    response.raise_for_status()

    data = response.json()
    print(data['product_id'])
    print(data['product_name'])
    print(data['price'])
    
except requests.exceptions.RequestException as e:
    print('Request Failed ',e)

# Q2 — Query Parameters 🟠
# Documentation:
# GET /products
# Query Parameters:
# category → Optional
# limit → Optional
# page → Optional
# Authentication:
# Bearer Token
# Response:
# [
#     {
#         "product_id": 1,
#         "product_name": "Laptop",
#         "price": 60000
#     }
# ]

import requests

token = '1234'

params = {
    'category' : 'Laptop',
    'limit' : 20,
    'page' : 2
}

headers = {
    "Authorization" : f"Bearer {token}"
}

try:

    response = requests.get(
        'https://api.example.com/products',
        headers= headers,
        params= params,
        timeout= 5
    )
    response.raise_for_status()

    data = response.json()

    for product in data:
        print(product['product_id'])
        print(product['product_name'])
        print(product['price'])
    
except requests.exceptions.RequestException as e:
    print('Request Failed ',e)


# Q3 — POST Documentation 🔥
# Documentation:
# POST /customers

# Authentication:
# Bearer Token

# Request Body:

# {
#     "customer_name": "string",
#     "city": "string",
#     "email": "string"
# }

# Success:
# 201 Created

# Response:

# {
#     "customer_id": 101,
#     "customer_name": "Yuvanesh",
#     "city": "Chennai",
#     "email": "yuva@example.com"
# }

import requests

token = '1234'

headers = {
    "Authentication" : f"Bearer {token}"
}

data = {
    "customer_name": "Yuvanesh",
    "city": "Chennai",
    "email": "yuva@example.com"
}

try:

    response = requests.post(
        'https://api.example.com/customers',
        headers= headers,
        json= data,
        timeout= 5
    )

    response.raise_for_status()

    print(response.status_code)

    data = response.json()
    if response.status_code == 201:

        print(data['customer_id'])
        print(data['customer_name'])
        print(data['city'])
        print(data['email'])    
    else:
        print('unexpected Status: ',response.status_code)
        
except requests.exceptions.RequestException as e:

    print('Request Failed ',e)


# Q4 — Documentation → Full Request 🔥🔥
# Imagine an API documentation page gives you:
# Base URL:
# https://api.example.com

# Endpoint:
# GET /orders

# Authentication:
# X-API-Key

# Query Parameters:

# customer_id → Optional
# status → Optional
# limit → Optional

# Response:

# {
#     "data": [
#         {
#             "order_id": 1,
#             "customer_id": 25,
#             "status": "delivered"
#         }
#     ],
#     "next_cursor": "abc123"
# }
# Write Python code to:
# - Authenticate using the API key
# - Request orders for customer_id = 25
# - Request maximum 50 records
# - Use a timeout
# - Check for HTTP errors
# - Parse the JSON
# - Extract the data list
# - Print each order_id and status
# - Print the next_cursor
# This is the most important question of this block because it combines the skills we've covered so far.

import requests

Base_URL = 'https://api.example.com/orders'

api_key = '1234'

headers = {
    'X-API-Key' : api_key
}

params = {
    'customer_id' : 25,
    'status' : 'Delivered',
    'limit' : 50
}

cursor = None

while True:

    if cursor:
        params['cursor'] = cursor

    try:
        response = requests.get(
            url= Base_URL,
            params= params,
            headers= headers,
            timeout= 5
        )

        response.raise_for_status()

        result = response.json()

        data = result.get('data',[])

        for order in data:
            print(order['order_id'])
            print(order['customer_id'])
            print(order['status'])

        cursor = result.get('next_cursor')

        if not cursor:
            break

    except requests.exceptions.RequestException as e:
        print('Request Failed: ',e)