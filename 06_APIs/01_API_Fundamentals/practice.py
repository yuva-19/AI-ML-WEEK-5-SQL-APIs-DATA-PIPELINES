# Q1 — API Response Inspection 🟡
# Using:
# https://jsonplaceholder.typicode.com/users
# Write a Python program that:
# - Sends a GET request.
# - Prints the HTTP status code.
# - Prints the Python type of the returned data.
# - Prints the number of users returned.
# - Prints the name and email of the 5th user.

import requests

response = requests.get(
    "https://jsonplaceholder.typicode.com/users"
)

print('HTTP status code: ', response.status_code)
print()

data = response.json()

print('Data Type: ', type(data))
print()

print('Number of users: ',len(data))
print()

print('5th User name and email: ')
print(data[4]['name'],data[4]['email'])
print()

# Q2 — Extract User Information 🟠
# Using the same API:
# https://jsonplaceholder.typicode.com/users
# Extract and print the following for every user:
# User ID
# Name
# Username
# Email
# City

for user in data:
    print('User ID: ',user['id'])
    print('Name: ',user['name'])
    print('Username: ',user['username'])
    print('Email: ',user['email'])
    print('City: ',user['address']['city'])
    print()
print()

# Q3 — Find Users by City 🔥
# Using the same API, find all users whose city is "South Christy".
# Your program should:
# 1. Fetch the API data.
# 2. Loop through the users.
# 3. Check the user's city.
# 4. Print the matching user's:
#    - ID
#    - Name
#    - Email
# You should not hard-code the user ID.
# The program should determine the matching users from the API response.
print("User's Whose city is South Christy")
for user in data:
    if user['address']['city'] == 'South Christy':
        print('User ID: ',user['id'])
        print('Name: ',user['name'])
        print('Email: ',user['email'])
        print()
print()
# Q4 — API Data Analysis 🔥🔥
# Using the same API, analyze the returned users.
# Your program must:
# - Fetch all users.
# - Count the total number of users.
# - Count how many users are from each city.
# - Print the city with the highest number of users.
# Expected type of output:
# Total users: 10

# Users by city:
# City A → 2
# City B → 1
# City C → 3
# ...
# Most common city: City C


print('Total Users: ',len(data))
city_count = {}
for user in data:
    city = user['address']['city']
    if city not in city_count:
        city_count[city] = 1
    else:
        city_count[city] += 1

for city,count in city_count.items():
    print(f'{city}:{count}\n')


most_common_city = max(city_count, key=city_count.get)
print("Most common city:", most_common_city)
    
