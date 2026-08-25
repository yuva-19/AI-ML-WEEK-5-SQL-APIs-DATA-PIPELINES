# Q1 — Understand Offset Pagination 🟡
# Imagine an API endpoint:
# https://api.example.com/products
# It accepts:
# limit
# offset
# Write Python code that requests 50 products at a time.
# Your program should:
# 1. Start with offset = 0.
# 2. Request 50 records.
# 3. Add the returned records to all_products.
# 4. Move to the next offset.
# 5. Continue until the API returns fewer than 50 records.
# Use the pagination pattern we discussed.

import requests

url = 'https://api.example.com/products'

all_products = []

limit = 50
offset = 0

while True:

    params ={
        'limit' : limit,
        'offset' : offset
    }

    response = requests.get(
        url= url,
        params= params
    )

    data = response.json()
    all_products.extend(data)

    if len(data) <limit:
        break

    offset+=limit

# Q2 — Fetch All Pages 🟠
# An API returns at most 100 customers per request:
# https://api.example.com/customers
# Write a program that keeps requesting pages until all customers are collected.
# Requirements:
# - Use limit
# - Use offset
# - Store everything in all_customers
# - Stop when the final page is reached
# - Finally print:
# Total customers collected: ...

import requests

url = 'https://api.example.com/customers'

limit = 100
offset = 0

all_customers=[]

while True:

    params = {
        'limit' : limit,
        'offset': offset
    }

    response = requests.get(
        url= url,
        params= params
    )

    data = response.json()

    all_customers.extend(data)

    if len(data) < limit:
        print('Total customers Collected: ' , len(all_customers))
        break
        

    offset+=limit


# Q3 — Cursor Pagination 🔥
# Suppose the API returns:
# {
#     "data": [
#         {"id": 1},
#         {"id": 2}
#     ],
#     "next_cursor": "abc123"
# }
# The next request must use:
# cursor=abc123
# Write Python code that:
# 1. Starts without a cursor.
# 2. Requests the API.
# 3. Extracts data.
# 4. Adds it to all_records.
# 5. Gets next_cursor.
# 6. Sends that cursor on the next request.
# 7. Stops when next_cursor is missing/empty.
# 8. Prints the total number of collected records.
import requests

url = 'https://api.example.com/data'

all_data=[]

cursor = None

while True:

    params = {}

    if cursor:
        params["cursor"] = cursor

    response = requests.get(
        url,
        params=params
    )

    result = response.json()

    all_data.extend(result["data"])

    cursor = result.get("next_cursor")

    if not cursor:
        break

# 4 — Pagination + DataFrame 🔥🔥
# An API provides products using offset pagination:
# https://api.example.com/products
# Each request accepts:
# limit
# offset
# Write a Python program that:
# 1. Fetches all pages.
# 2. Stores all products in a list.
# 3. Converts the final result into a pandas DataFrame.
# 4. Prints:
#    - Number of products collected
#    - DataFrame shape
#    - First 5 rows
# Expected pipeline:
# API
#  ↓
# Pagination
#  ↓
# all_products
#  ↓
# DataFrame
#  ↓
# Analysis
# Don't worry about making the fake endpoint actually work. The goal is to practice the pagination logic.

import requests

url = 'https://api.example.com/products'

limit = 100
offset = 0

all_products=[]

while True:

    params = {
        'limit' : limit,
        'offset': offset
    }

    response = requests.get(
        url= url,
        params= params
    )

    data = response.json()

    all_products.extend(data)

    if len(data) < limit:
        break

    offset+=limit

import pandas as pd

df = pd.DataFrame(all_products)
print("Number of products:", len(all_products))
print("DataFrame shape:", df.shape)
print(df.head(5))