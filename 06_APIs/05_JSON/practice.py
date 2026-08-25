# 1 — Inspect JSON Structure 🟡
# Using:
# https://jsonplaceholder.typicode.com/users
# Write a Python program that:
# 1. Sends a GET request.
# 2. Converts the response to JSON.
# 3. Prints:
#    - Type of data
#    - Type of the first element
#    - Number of users
# 4. Prints the complete JSON of the first user.
# Goal
# You should determine that the structure is essentially:
# list
#  ↓
# dictionary

import requests

response = requests.get(
    'https://jsonplaceholder.typicode.com/users'
)
data = response.json()
print(type(data))
print(type(data[0]))
print(len(data))
print('\n',data[0])
print()

# Q2 — Extract Nested JSON 🟠
# Using the same API, loop through all users and print:
# Name
# Email
# City
# Company Name
# The company name is nested inside:
# user
#  └── company
#       └── name
# So you'll need to navigate nested dictionaries.
# Example output format
# Leanne Graham | leanne@example.com | Gwenborough | Romaguera-Crona
# Ervin Howell | erwin@example.com | Wisokyburgh | Deckow-Crist
# ...

for user in data:
    print(f" {user['name']} | {user['email']} | {user['address']['city']} | {user['company']['name']}")


# Q3 — JSON → DataFrame 🔥
# Using the same API:
# 1. Fetch all users.
# 2. Convert the response to JSON.
# 3. Create a pandas DataFrame.
# 4. Display these columns only:
# id
# name
# email
# phone
# website
# 5. Print the DataFrame.
# Goal
# Practice the pipeline:
# API → JSON → Python → DataFrame

import pandas as pd
df = pd.DataFrame(data)
print(df)

print(df[['id','name','email','phone','website']])


# Q4 — Flatten Nested JSON 🔥🔥
# Using:
# https://jsonplaceholder.typicode.com/users
# Create a DataFrame containing:
# id
# name
# email
# address.city
# address.geo.lat
# address.geo.lng
# company.name
# You should not manually create each row.
# Use:
# pd.json_normalize(...)
# to flatten the nested JSON.
# Then print the resulting DataFrame.
# Goal
# Practice:
# Nested API JSON
#        ↓
# json_normalize()
#        ↓
# Flat DataFrame
print()
df_normalized = pd.json_normalize(data)

df_normalized = df_normalized[
    [
        'id',
        'name',
        'email',
        'address.city',
        'address.geo.lat',
        'address.geo.lng',
        'company.name'
    ]
]

print(df_normalized)