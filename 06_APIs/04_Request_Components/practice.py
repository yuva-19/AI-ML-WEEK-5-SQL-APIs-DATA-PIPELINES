# Q1 — Path Parameter 🟡
# Using:
# https://jsonplaceholder.typicode.com/users
# Write a Python program that:
# 1. Stores 5 in a variable called user_id.
# 2. Uses the variable as a path parameter.
# 3. Sends a GET request for that specific user.
# 4. Prints:
#    - Status code
#    - User name
#    - User email
# 5. Print the final URL using:
# print(response.url)
import requests
user_id =  5
response = requests.get(
    f'https://jsonplaceholder.typicode.com/users/{user_id}'
)
print(response.status_code)
data = response.json()
print(data['username'])
print(data['email'])
print(response.url)
print()

# Q2 — Query Parameters 🟠
# Using the same API:
# https://jsonplaceholder.typicode.com/users
# Use query parameters to search for users whose username is:
# Bret
# Your program should:
# 1. Create a params dictionary.
# 2. Send it using requests.get(..., params=params).
# 3. Print the final URL.
# 4. Convert the response to JSON.
# 5. Print the matching user's:
#    - ID
#    - Name
#    - Email
# Do not manually write ?username=Bret into the URL.

params = {
    'username' : 'Bret'
}

response = requests.get(
    'https://jsonplaceholder.typicode.com/users',
    params=params
)

print(response.status_code)

data = response.json()

print(data[0]['id'])
print(data[0]['name'])
print(data[0]['email'])
print(response.url)
print()


# Q3 — Multiple Query Parameters 🔥
# Using the same API, send these two query parameters:
# username = Bret
# email = Sincere@april.biz
# Your program should:
# 1. Store them inside a params dictionary.
# 2. Send them using params=params.
# 3. Print:
#    - Status code
#    - Final URL
#    - Number of users returned
#    - Name of the returned user
# Hint about the structure only:
# params = {
#     ...
# }
# Then:
# requests.get(
#     ...,
#     params=params
# )

params = {
    'username' : 'Bret',
    'email' : 'Sincere@april.biz'
}

response = requests.get(
    'https://jsonplaceholder.typicode.com/users',
    params=params
)

print(response.status_code)
print(response.url)

data = response.json()

print("Number of Users Returned: ",len(data))

print('\nName of the returned user: ')
for user in data:
    print(user['name'])


# Q4 — POST Request with Headers + JSON Body 🔥🔥
# Using:
# https://jsonplaceholder.typicode.com/users
# Create a new user with:
# name     → Yuvanesh
# username → yuva19
# email    → yuva@example.com
# Your program should:
# 1. Create a data dictionary.
# 2. Create a headers dictionary containing:
# Accept: application/json
# 3. Send a POST request.
# 4. Send the user data using:
# json=data
# 5. Print:
#    - Status code
#    - Returned JSON
#    - Returned user's name
#    - Returned user's email

import requests

data = {
    "name": "Yuvanesh",
    "username": "yuva19",
    "email": "yuva@example.com"
}

headers = {
    "Accept": "application/json"
}

response = requests.post(
    "https://jsonplaceholder.typicode.com/users",
    headers=headers,
    json=data
)

print(response.status_code)
print(response.json())
print(response.json()['name'])
print(response.json()['email'])
