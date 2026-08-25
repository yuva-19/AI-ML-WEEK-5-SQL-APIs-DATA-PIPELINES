# Q1 — GET + Parameters + JSON 🟡
# Using:
# https://jsonplaceholder.typicode.com/users
# Write a program that:
# - Sends a GET request
# - Uses username="Bret" as a query parameter
# - Checks the status code
# - Converts the response to JSON
# - Prints:
#   - number of users returned
#   - name
#   - email
#   - city
# - Prints the final URL

import requests

params = {
    'username' : 'Bret',
}

try:

    response = requests.get(
        'https://jsonplaceholder.typicode.com/users',
        params= params,
        timeout= 5
    )

    response.raise_for_status()

    data = response.json()

    print(response.status_code)

    print(len(data))

    for user in data:
        print(user['name'])
        print(user['email'])
        print(user['address']['city'])
        

    print(response.url)

except requests.exceptions.RequestException as e:
    print('Request Failed  ',e)

# Q2 — POST + Headers 🟠
# Using:
# https://jsonplaceholder.typicode.com/users
# Create a new user with:
# name
# username
# email
# Send:
# Accept: application/json
# as a header.
# Your program must:
# - Send the POST request
# - Check for successful creation (201)
# - Print the status code
# - Print the returned JSON
# - Print the created user's name and email


import requests

data = {
    'name' : 'yuva',
    'username' : 'yuva19',
    'email' : 'yuva@gmail.com'
}

headers = {
    'Accept' : 'application/json'
}

try:

    response = requests.post(
        'https://jsonplaceholder.typicode.com/users',
        json= data,
        headers= headers,
        timeout= 5
    )

    response.raise_for_status()

    data = response.json()

    print(response.status_code)

    print(data)
 
    print(data['name'])
    print(data['email'])

    print(response.url)

except requests.exceptions.RequestException as e:
    print('Request Failed  ',e)


# Q3 — JSON → Pandas 🔥
# Fetch all users from:
# https://jsonplaceholder.typicode.com/users
# Convert the response into a DataFrame containing:
# id
# name
# username
# email
# city
# company_name
# Remember:
# city → address → city

# company_name → company → name
# Print:
# - DataFrame
# - Number of rows
# - First 5 rows

import requests
import pandas as pd
try:

    response = requests.get(
        'https://jsonplaceholder.typicode.com/users',
        timeout= 5
    )

    response.raise_for_status()

    data = response.json()

    df_normalized = pd.json_normalize(data)

    print(df_normalized.columns)

    df_normalized.rename(columns={'address.city': 'city','company.name':'company_name'},inplace=True)

    df_normalized = df_normalized[
        [
            'id',
            'name',
            'username',
            'email',
            'city',
            'company_name'
        ]
    ]
    print(len(data))
    print(df_normalized)
    print(df_normalized.head(5))

except requests.exceptions.RequestException as e:
    print('Request Failed  ',e)

# Q4 — Pagination + Authentication 🔥🔥
# Imagine the API documentation says:
# GET https://api.example.com/products

# Authentication:
# Bearer Token

# Parameters:
# limit
# offset

# Maximum limit:
# 100
# Write a program that:
# - Uses a Bearer token
# - Requests 100 products at a time
# - Uses offset pagination
# - Collects all products
# - Stops when the final page contains fewer than 100 records
# - Uses a timeout of 5 seconds
# - Handles request errors
# - Prints the total number of products collected

import requests

token = '1234'
limit = 100
offset = 0


all_products = []
while True:
    try:
        params = {
            'limit' : limit,
            'offset' : offset
        }

        headers = {
        'Authorization' : f"Bearer {token}"
        }


        response = requests.get(
            'https://api.example.com/products',
            params= params,
            headers= headers,
            timeout= 5
        )

        response.raise_for_status()

        data = response.json()
        all_products.extend(data)

        if len(data) < limit:
            print(len(all_products))
            break

        offset+=limit


    except requests.exceptions.RequestException as e:
        print('Request Failed  ',e)
        break


# Q5 — 🔥🔥🔥 Production-Style Combined Question
# Imagine:
# GET https://api.example.com/customers
# Documentation:
# Authentication:
# X-API-Key

# Parameters:
# city
# limit
# offset

# Maximum limit:
# 100
# Write a complete Python program that:
# 1. Sends the API key through headers.
# 2. Retrieves customers from:
# city = Chennai
# 3. Uses pagination with limit=100.
# 4. Uses a timeout.
# 5. Handles:
#    - timeout
#    - request errors
#    - HTTP errors
# 6. Collects all returned customers.
# 7. Converts them into a Pandas DataFrame.
# 8. Prints:
#    - total customers
#    - first 5 rows
#    - DataFrame shape

import requests
import pandas as pd

limit = 100
offset = 0

api_key = '1234'

all_customers = []

while True:
    try:
        params = {
            'city' : 'chennai',
            'limit' : limit,
            'offset' : offset
        }

        headers ={
                'X-API-Key' : api_key,
                "Accept": "application/json"
        }
        

        response = requests.get(
            'https://api.example.com/customers',
            params= params,
            headers= headers,
            timeout= 5
        )

        response.raise_for_status()

        data = response.json()
        all_customers.extend(data)

        if len(data) < limit:
            print(len(all_customers))
            df_normalized = pd.json_normalize(all_customers)
            print(df_normalized.head())
            print(df_normalized.shape)

            break

        offset+=limit


    except requests.exceptions.RequestException as e:
        print('Request Failed  ',e)
        break