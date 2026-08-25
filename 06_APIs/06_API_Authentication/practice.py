# Q1 — API Key Header 🟡
# Create a Python program that prepares a GET request for:
# https://api.example.com/products
# Use this fake API key:
# demo_key_123
# Your program should:
# 1. Store the key in api_key.
# 2. Create a headers dictionary.
# 3. Send the key using:
# X-API-Key
# 4. Make the GET request.
# 5. Print the status code.
# Goal
# Practice:
# API key → header → GET request
# You don't need the API to actually work.

import requests

api_key = "demo_key_123"

headers = {
    "X-API-Key": api_key
}

response = requests.get(
    "https://api.example.com/data",
    headers=headers
)

print(response.status_code)


# Q2 — Bearer Token 🟠
# Create a GET request to:
# https://api.example.com/orders
# using this fake token:
# demo_token_456
# Send it as a Bearer token.
# Your headers should conceptually contain:
# Authorization: Bearer demo_token_456
# Print:
# - Status code
# - Response URL
# Goal
# Practice constructing the Authorization header correctly.

token = 'demo_token_456'

headers = {
    "Authorization" : f"Bearer {token}"
}

response = requests.get(
    'https://api.example.com/orders',
    headers= headers
)

print(response.status_code)



# Q3 — Authentication + Query Parameters 🔥
# Imagine an API provides customer data:
# https://api.example.com/customers
# You have:
# API key = demo_key_789
# city = Chennai
# Build a GET request that sends:
# API key → header
# city → query parameter
# Your request should therefore contain:
# Headers
#     ↓
# X-API-Key

# Query parameters
#     ↓
# city=Chennai
# Print:
# - Status code
# - Response URL
# Goal
# Make sure you understand that authentication and query parameters are different parts of the request.


api_key = 'demo_key_789'

headers = {
    'X-API-Key' : api_key
}

params = {
    'city' : 'Chennai'
}

response = requests.get(
    'https://api.example.com/customers',
    headers= headers,
    params= params
)

print(response.status_code)
print(response.url)


# Q4 — Environment Variable 🔥🔥
# Write a Python program that gets an API key from an environment variable:
# API_KEY
# Then use that value in:
# X-API-Key
# for a GET request to:
# https://api.example.com/products
# Your code should not contain the actual API key directly.
# Use:
# os.getenv()
# Goal
# Practice the production habit:
# Secret
#  ↓
# Environment variable
#  ↓
# Python
#  ↓
# Request header
#  ↓
# API

import requests

from dotenv import load_dotenv
import os

load_dotenv()

api_key = os.getenv('API_KEY')

headers = {
    'X-API-Key' : api_key
}

response = requests.get(
    'https://api.example.com/products',
    headers= headers
)

print(response.status_code)
