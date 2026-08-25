# BLOCK 10 — API Documentation 📚

## 1. What is API Documentation?

API documentation is the **instruction manual for using an API**.

It tells you:

- Which endpoints are available
- Which HTTP method to use
- What parameters are required
- What headers are required
- What request body to send
- What authentication is needed
- What response you will receive
- What errors can occur
- Rate limits and restrictions

### Basic idea

```text
API Documentation
       ↓
Understand the API
       ↓
Build Python request
       ↓
Send request
       ↓
Process response
```

---

# 2. Finding an Endpoint

An API may provide endpoints such as:

```text
GET    /products
GET    /products/{product_id}
POST   /products
GET    /customers
POST   /customers
GET    /orders
```

You need to identify:

```text
HTTP Method + Endpoint
```

Example:

```text
GET /products/5
```

means:

```python
requests.get(
    "https://api.example.com/products/5"
)
```

---

# 3. Base URL

The **base URL** is the common starting part of the API.

Example:

```text
https://api.example.com
```

Endpoint:

```text
/products
```

Complete URL:

```text
https://api.example.com/products
```

You can store it:

```python
BASE_URL = "https://api.example.com"
```

and build URLs from it:

```python
url = f"{BASE_URL}/products"
```

---

# 4. Path Parameters

Path parameters identify a **specific resource**.

Documentation:

```text
GET /products/{product_id}
```

If:

```python
product_id = 5
```

use:

```python
url = f"https://api.example.com/products/{product_id}"
```

Result:

```text
https://api.example.com/products/5
```

### Important ⚠️

This:

```python
"https://api.example.com/products/{product_id}"
```

does **not** replace `{product_id}`.

Use an **f-string**:

```python
f"https://api.example.com/products/{product_id}"
```

---

# 5. Query Parameters

Query parameters are used for **filtering, searching, sorting, pagination, etc.**

Documentation:

```text
GET /products

Parameters:
category
limit
page
```

Python:

```python
params = {
    "category": "Laptop",
    "limit": 20,
    "page": 2
}

response = requests.get(
    url,
    params=params
)
```

The resulting URL may look like:

```text
/products?category=Laptop&limit=20&page=2
```

### Remember

```text
Path parameter
→ identifies a resource

Query parameter
→ filters/modifies the request
```

Example:

```text
/products/5
          ↑
     Path parameter
```

```text
/products?category=Laptop&limit=20
          ↑
      Query parameters
```

---

# 6. Request Headers

Documentation may specify required headers.

Example:

```text
X-API-Key: YOUR_API_KEY
```

Python:

```python
headers = {
    "X-API-Key": api_key
}
```

Then:

```python
requests.get(
    url,
    headers=headers
)
```

Another common example:

```text
Authorization: Bearer TOKEN
```

Python:

```python
headers = {
    "Authorization": f"Bearer {token}"
}
```

### Important ⚠️

**Header names must match the API documentation exactly.**

Don't invent:

```text
Authentication
```

when documentation says:

```text
Authorization
```

---

# 7. Request Body

Some APIs require data to be sent in the request body, usually with:

- POST
- PUT
- PATCH

Example documentation:

```json
{
    "customer_name": "Yuvanesh",
    "city": "Chennai",
    "email": "yuva@example.com"
}
```

Python:

```python
data = {
    "customer_name": "Yuvanesh",
    "city": "Chennai",
    "email": "yuva@example.com"
}

response = requests.post(
    url,
    json=data
)
```

### Important

```python
json=data
```

sends the Python dictionary as JSON.

---

# 8. Request vs Response ⭐⭐⭐

This is **very important**.

### Request

Data **you send to the API**:

```python
data = {
    "customer_name": "Yuvanesh",
    "city": "Chennai"
}
```

```python
requests.post(
    url,
    json=data
)
```

### Response

Data **the API sends back**:

```python
response = requests.post(...)
```

Then:

```python
result = response.json()
```

Think:

```text
YOU
 ↓
REQUEST
 ↓
API
 ↓
RESPONSE
 ↓
YOU
```

---

# 9. Response Schema

API documentation usually tells you what the response looks like.

Example:

```json
{
    "product_id": 5,
    "product_name": "Laptop",
    "price": 65000
}
```

Python:

```python
data = response.json()

print(data["product_id"])
print(data["product_name"])
print(data["price"])
```

If response is an **array**:

```json
[
    {
        "product_id": 1,
        "product_name": "Laptop"
    },
    {
        "product_id": 2,
        "product_name": "Mouse"
    }
]
```

then:

```python
data = response.json()

for product in data:
    print(product["product_id"])
    print(product["product_name"])
```

### Always check the response structure in the documentation.

Don't assume:

```python
data["product_id"]
```

if the response is actually:

```python
[
    {...},
    {...}
]
```

---

# 10. Authentication Requirements

Documentation tells you how the API expects authentication.

Common examples:

### API Key

```python
headers = {
    "X-API-Key": api_key
}
```

### Bearer Token

```python
headers = {
    "Authorization": f"Bearer {token}"
}
```

Always follow the authentication format specified by the API.

---

# 11. Rate Limits

APIs may restrict how many requests you can make.

Example:

```text
100 requests per minute
```

If you exceed the limit, the API may return:

```text
429 Too Many Requests
```

Documentation should tell you:

- Request limits
- Time window
- What happens after exceeding the limit
- Sometimes retry information

---

# 12. Reading API Documentation — Your Process 🧠

Whenever you encounter a new API, follow this order:

```text
1. Find BASE URL
        ↓
2. Find ENDPOINT
        ↓
3. Check HTTP METHOD
        ↓
4. Check PATH PARAMETERS
        ↓
5. Check QUERY PARAMETERS
        ↓
6. Check HEADERS
        ↓
7. Check AUTHENTICATION
        ↓
8. Check REQUEST BODY
        ↓
9. Check RESPONSE FORMAT
        ↓
10. Check STATUS CODES / ERRORS
        ↓
11. Check RATE LIMITS
```

Then write your Python request.

---

# 13. OpenAPI / Swagger — Introduction

**OpenAPI** is a standard format for describing APIs.

**Swagger** is a collection of tools commonly used around OpenAPI documentation.

They can provide information about:

- Endpoints
- HTTP methods
- Parameters
- Request bodies
- Responses
- Authentication

You may see an interactive page where you can test endpoints directly.

### For now

You only need to understand:

> **OpenAPI/Swagger helps developers understand and test an API from structured documentation.**

No need to master it yet.

---

# ⭐ Final Revision

```text
Endpoint
→ Where to send the request

HTTP Method
→ What operation to perform

Path Parameter
→ Identifies a specific resource

Query Parameter
→ Filters/modifies the request

Headers
→ Additional request information/authentication

Body
→ Data sent to the API

Authentication
→ Proves that you are allowed to access the API

Response Schema
→ Structure of returned data

Status Code
→ Tells whether the request succeeded or failed

Rate Limit
→ Restricts how frequently you can call the API
```

### 🔥 Most important skill from this block

You should be able to open **any API documentation**, look at an endpoint like:

```text
GET /products/{product_id}
```

and figure out:

```python
response = requests.get(
    f"https://api.example.com/products/{product_id}",
    headers=headers,
    params=params,
    timeout=5
)
```

**That is the actual skill we're building here.**