# Q1 — GET + Parameters 🟡
# Using:
# https://jsonplaceholder.typicode.com/users
# Write a program that:
# 1. Uses requests.get().
# 2. Searches for users with:
# username = Bret
# 3. Uses params.
# 4. Uses a 5 second timeout.
# 5. Prints:
#    - Status code
#    - Number of users returned
#    - Name and email of each returned user
#    - Final URL

import requests

params = {
    'username' : 'Bret'
}

try:

    response = requests.get(
        'https://jsonplaceholder.typicode.com/users',
        params= params,
        timeout= 5
    )
    data = response.json()

    print(response.status_code)
    print('\nNumber of users Returned: ',len(data))
    print()

    for user in data:
        print('Name: ',user['name'])
        print('Email: ',user['email'])
        print(response.url)

except requests.exceptions.Timeout:
    print('Timout')

except requests.exceptions.RequestException as e:
    print('Request Failed: ', e) 


# Q2 — POST + JSON 🟠
# Using:
# https://jsonplaceholder.typicode.com/users
# Create a new user with:
# name
# username
# email
# Requirements:
# - Use requests.post().
# - Send the data using json=.
# - Use a 5 second timeout.
# - Check the status code.
# - If the response is successful, print:
#   - Created user's ID
#   - Name
#   - Email  

import requests

data = {
    'name' : 'Yuva',
    'username' : 'yuva19',
    'email' : 'yuva19@mail.com'
}

response = requests.post(
    'https://jsonplaceholder.typicode.com/users',
     json= data,
     timeout= 5
)

print(response.status_code)
print(data['name'])
print(data['email'])

# Q3 — GET + Headers + Error Handling 🔥
# Using:
# https://jsonplaceholder.typicode.com/users/5
# Write a program that:
# - Uses a custom Accept header:
# {
#     "Accept": "application/json"
# }
# - Uses a 5-second timeout.
# - Uses try/except.
# - Uses raise_for_status().
# - If successful, print:
#   - User ID
#   - Name
#   - Email
# If the request fails, print the exception.

import requests

headers = {
    'Accept' : 'application/json'
}

try:

    response = requests.get(
        'https://jsonplaceholder.typicode.com/users/5',
        headers= headers,
        timeout= 5
    )
        
    response.raise_for_status()
    
    data = response.json()
    print('User ID: ', data['id'])
    print('Name: ', data['name'])
    print('Email: ', data['email'])

    
except requests.exceptions.Timeout:
    print('Timout')

except requests.exceptions.RequestException as e:
    print('Request Failed: ', e) 


# Q4 — Session 🔥🔥
# Create a requests.Session().
# Configure the session with:
# Accept: application/json
# Then use the same session to make two requests:
# https://jsonplaceholder.typicode.com/users/1
# https://jsonplaceholder.typicode.com/users/2
# For each response, print:
# Status:
# Name:
# Email:
# Goal: demonstrate that you understand why 
# a Session can be useful when making multiple requests to the same API.

import requests

session = requests.Session()

session.headers.update({
    "Accept": "application/json"
})

response1 = session.get('https://jsonplaceholder.typicode.com/users/1')
response2 = session.get('https://jsonplaceholder.typicode.com/users/2')

data1 = response1.json()
data2 = response2.json()

print(response1.status_code)
print(data1['name'])
print(data1['email'])
print()

print(response2.status_code)
print(data2['name'])
print(data2['email'])
print()