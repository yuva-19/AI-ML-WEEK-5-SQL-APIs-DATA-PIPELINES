# Block 1 — API Fundamentals

## 1. What is an API?

**API (Application Programming Interface)** allows one software application to communicate with another software application.

For AI/ML engineers, APIs are commonly used to collect data from:

- Public services
- SaaS platforms
- Cloud services
- ML services
- LLM services
- Internal company systems

Basic flow:

```text
Python Program
     ↓
   API Request
     ↓
   API Server
     ↓
   API Response
     ↓
Python Program
```

---

## 2. Client

The **client** is the application that makes the request.

Example:

```text
Python program → Client
```

When we use:

```python
requests.get(...)
```

our Python program is acting as the client.

---

## 3. Server

The **server** receives the request, processes it, and sends a response.

```text
Client                 Server
Python  ─────────────→ API Server
        Request

Python  ←───────────── API Server
        Response
```

---

## 4. API Endpoint

An **endpoint** is a specific URL/address through which an API provides access to a resource or operation.

Example:

```text
https://jsonplaceholder.typicode.com/users
```

Here:

```text
https://jsonplaceholder.typicode.com
        ↓
      Server

/users
   ↓
Endpoint / resource path
```

Another endpoint might be:

```text
/users/5
```

which could represent one specific user.

### Think:

```text
Endpoint = Where we send the API request
```

---

## 5. Resource

A **resource** is the data/entity that an API exposes.

Examples:

```text
/users
/products
/orders
/customers
```

For example:

```text
/users
```

represents the **users resource**.

---

## 6. URI and URL

### URI

**URI (Uniform Resource Identifier)** identifies a resource.

### URL

**URL (Uniform Resource Locator)** identifies a resource **and tells us where/how to access it**.

For beginner API work, you will mostly work with URLs.

Example:

```text
https://api.example.com/products
```

---

## 7. Request

A **request** is the message sent by the client to the server.

Example:

```python
import requests

response = requests.get(
    "https://jsonplaceholder.typicode.com/users"
)
```

The important part:

```python
requests.get(url)
```

means:

> Send a GET request to this API endpoint.

---

## 8. Response

The **response** is what the server sends back.

```python
response = requests.get(url)
```

The variable:

```python
response
```

contains the server's response.

A successful response may have:

```text
<Response [200]>
```

---

## 9. HTTP Status Code

The response contains a **status code** that tells us what happened.

Example:

```python
print(response.status_code)
```

Common codes:

```text
200 → Request successful
201 → Resource successfully created
400 → Bad request
401 → Authentication required/invalid
403 → Forbidden
404 → Resource not found
429 → Too many requests
500 → Server error
503 → Service unavailable
```

For now, remember:

```text
2xx → Generally successful
4xx → Client/request problem
5xx → Server problem
```

---

# 10. JSON Response

Most modern APIs return data as **JSON**.

Example:

```json
{
    "id": 1,
    "name": "Leanne Graham",
    "email": "example@email.com"
}
```

Multiple records may be returned as an array:

```json
[
    {
        "id": 1,
        "name": "Leanne Graham"
    },
    {
        "id": 2,
        "name": "Ervin Howell"
    }
]
```

---

# 11. Reading JSON with Python

Using `requests`:

```python
import requests

response = requests.get(
    "https://jsonplaceholder.typicode.com/users"
)

data = response.json()
```

`response.json()` converts the JSON response into normal Python data structures.

Usually:

```text
JSON object → Python dictionary
JSON array  → Python list
```

Example:

```python
print(type(data))
```

may give:

```text
<class 'list'>
```

Then:

```python
print(data[0])
```

gets the first user.

And:

```python
print(data[0]["name"])
```

gets that user's name.

---

# 12. Complete Basic API Pattern

```python
import requests

response = requests.get(
    "https://jsonplaceholder.typicode.com/users"
)

print("Status:", response.status_code)

data = response.json()

print(data)
```

Basic flow:

```text
requests.get()
      ↓
HTTP Request
      ↓
API Server
      ↓
HTTP Response
      ↓
response
      ↓
response.json()
      ↓
Python data
```

---

# 13. Important Terminology

| Term | Meaning |
|---|---|
| API | Interface for software communication |
| Client | Application making the request |
| Server | Application processing the request |
| Resource | Data/entity exposed by an API |
| Endpoint | Specific API address |
| URI | Identifier of a resource |
| URL | Address used to locate/access a resource |
| Request | Message sent to the server |
| Response | Message returned by the server |
| JSON | Common format for API data |
| Status code | Indicates the result of a request |

---

# 14. The Mental Model to Remember

```text
CLIENT
Python program
     │
     │ HTTP REQUEST
     ▼
API ENDPOINT
     │
     ▼
SERVER
     │
     │ HTTP RESPONSE
     ▼
JSON DATA
     │
     ▼
Python
     │
     ▼
Pandas / Data Processing / ML
```