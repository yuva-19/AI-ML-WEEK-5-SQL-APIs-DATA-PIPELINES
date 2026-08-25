# # Exceptions
# except requests.exceptions.Timeout:

# except requests.exceptions.RequestException as e:
#     print("Request failed:", e)




# 🧪 PRACTICE QUESTIONS
# Q1 — Basic Error Handling 🟡
# Write a Python program that:
# 1. Sends a GET request to:
# https://jsonplaceholder.typicode.com/users
# 2. Uses a 5-second timeout.
# 3. If the request succeeds, print:
#    - Status code
#    - Number of users
# 4. If the request fails because of a request-related error, print:
# Request failed: ...

import requests

try:
    response = requests.get(
        'https://jsonplaceholder.typicode.com/users',
        timeout= 5
    )

    print(response.status_code)

    data = response.json()

    print('Number of Users: ',len(data))

except requests.exceptions.RequestException as e:
    print('Request Failed: ',e)
print()

# Q2 — Handle Different Status Codes 🟠
# Using:
# https://jsonplaceholder.typicode.com/users/999
# write a program that:
# - Sends a GET request.
# - Checks the status code.
# - Prints:
# 200 → Success
# 404 → User not found
# Other → Unexpected status
# Do not hard-code the result. Determine it from response.status_code.

import requests

response = requests.get(
    'https://jsonplaceholder.typicode.com/users/999'
)

if response.status_code == 200:
    print('Success')

elif response.status_code == 404:
    print('User Not Found')

else:
    print('Unexpected status')

print()

# Q3 — Retry Failed Requests 🔥
# Write a program that attempts to request:
# https://jsonplaceholder.typicode.com/users
# a maximum of 3 times.
# Requirements:
# - Use timeout=5.
# - Use try/except.
# - Use raise_for_status().
# - If successful → print the number of users and stop retrying.
# - If the request fails → print the attempt number.
# - After 3 failed attempts → print:
# All attempts failed


import requests

for attempt in range(3):

    try:
        response = requests.get(
            'https://jsonplaceholder.typicode.com/users',
            timeout= 5
        )

        response.raise_for_status()

        data = response.json()

        print('Number of users: ',len(data))
        break

    except:
       print(f'attempt {attempt+1} is failed ',e)
       
       if attempt == 2:
         print('All the attempts Failed')


# Q4 — Retry + Backoff 🔥🔥
# Modify Q3 so that when a request fails:
# Attempt 1 → wait 1 second
# Attempt 2 → wait 2 seconds
# Attempt 3 → stop
# Use:
# time.sleep()
# and calculate the waiting time using:
# 2 ** attempt
# Don't worry about deliberately making JSONPlaceholder fail. The goal is to implement the retry/error-handling logic correctly.

import requests
import time

url = "https://jsonplaceholder.typicode.com/users/999"

for attempt in range(3):

    try:
        response = requests.get(
            url,
            timeout=5
        )

        # Handle errors that should NOT be retried
        
        if response.status_code == 404:
            print("User not found. No retry needed.")
            break

        if response.status_code == 401:
            print("Unauthorized. No retry needed.")
            break

        if response.status_code == 403:
            print("Forbidden. No retry needed.")
            break

        # Raise exception for other HTTP errors
        response.raise_for_status()

        data = response.json()

        print("Success")
        print('Number of Users: ',len(data))

        break

    except requests.exceptions.RequestException as e:

        print(f"Attempt {attempt + 1} failed:", e)

        if attempt < 2:
            wait_time = 2 ** attempt

            print(f"Waiting {wait_time} seconds...")
            time.sleep(wait_time)

        else:
            print("All attempts failed")