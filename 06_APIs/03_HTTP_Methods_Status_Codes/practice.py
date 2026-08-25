# 2
import requests

response = requests.get(
    'https://jsonplaceholder.typicode.com/users'
)

if response.status_code == 200:
    print('Status: ',response.status_code)
    print("Result: SUCCESS") 

elif response.status_code == 404:
    print('Status: ',response.status_code)
    print("Result:  NOT FOUND") 

else:
    print('Status: ',response.status_code)
    print("Result:  OTHER ERROR")


response = requests.get(
    'https://jsonplaceholder.typicode.com/users/5'
)

if response.status_code == 200:
    print('Status: ',response.status_code)
    print("Result: SUCCESS") 

elif response.status_code == 404:
    print('Status: ',response.status_code)
    print("Result:  NOT FOUND") 

else:
    print('Status: ',response.status_code)
    print("Result:  OTHER ERROR")

response = requests.get(
    'https://jsonplaceholder.typicode.com/users/999'
)

if response.status_code == 200:
    print('Status: ',response.status_code)
    print("Result: SUCCESS") 

elif response.status_code == 404:
    print('Status: ',response.status_code)
    print("Result:  NOT FOUND") 

else:
    print('Status: ',response.status_code)
    print("Result:  OTHER ERROR")




# 1
import requests

response = requests.get(
    'https://jsonplaceholder.typicode.com/users'
)

if response.status_code == 200:
    print('Status: ',response.status_code)
    print("Result: SUCCESS")
    data = response.json() 
    print('Number of users: ',len(data))
    print("First user's Name: ",data[0]['name'])

elif response.status_code == 404:
    print('Status: ',response.status_code)
    print("Result:  NOT FOUND") 

else:
    print('Status: ',response.status_code)
    print("Result:  OTHER ERROR")


# 3

data = {
    "name": "Yuvanesh",
    "username": "yuva19",
    "email": "yuva@example.com"
}

response = requests.post(
    'https://jsonplaceholder.typicode.com/users',
    json = data
)
print(response.status_code)

if response.status_code == 201:
    print(response.status_code)
    print('Created')


