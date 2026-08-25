# BLOCK 2 — REST APIs
# REST APIs

## 1. What is REST?

**REST** stands for:

**Representational State Transfer**

REST is a set of principles for designing APIs so that clients and servers can communicate in a simple, predictable way.

A REST API generally works with **resources**.

Examples of resources:

```text
/users
/products
/orders
/customers
```

---

## 2. REST API Architecture

The basic architecture is:

```text
Client
   │
   │ HTTP Request
   ↓
Server / API
   │
   │ HTTP Response
   ↓
Client
```

### Client

The client is the application making the request.

Examples:

- Python program
- Web browser
- Mobile application
- Frontend application
- Another server

Example:

```python
import requests

response = requests.get(
    "https://jsonplaceholder.typicode.com/users"
)
```

Here, the Python program is the **client**.

---

## 3. Server

The server receives the request, processes it, and sends a response.

For example:

```text
Client
   ↓
GET /users
   ↓
Server
   ↓
Retrieve users
   ↓
JSON Response
```

The client does not directly access the server's database.

```text
Client → API → Database
```

The API acts as the communication layer.

---

# 4. Resources

REST APIs are organized around **resources**.

Examples:

```text
/users
/products
/orders
/customers
```

A specific resource can be identified using an ID:

```text
/users/10
/products/25
/orders/1001
```

Think of:

```text
/users
```

as the collection of users.

And:

```text
/users/10
```

as one specific user.

---

# 5. Resource-Based Thinking

REST focuses on **what resource you're working with**, rather than putting the action directly into the URL.

### REST-style

```text
GET /users/10
```

Meaning:

> Get user 10.

### Less REST-like design

```text
GET /getUser?id=10
```

Both can technically work, but REST APIs generally use resource-oriented URLs.

---

# 6. Statelessness

One of the most important REST principles is:

> **Each request should contain the information needed to process that request.**

The server should not depend on previous requests to understand the current request.

Example:

```text
Request 1
GET /users/10

Request 2
GET /users/20
```

The server should be able to process Request 2 independently.

Conceptually:

```text
Request 1 → Server
             ↓
           Response

Request 2 → Server
             ↓
           Response
```

The server shouldn't need:

```text
"What happened in Request 1?"
```

in order to understand Request 2.

---

# 7. Why Statelessness Matters

Stateless APIs are easier to:

- Scale
- Debug
- Maintain
- Distribute across multiple servers

For example:

```text
              ┌── Server 1
Client → API ─┼── Server 2
              └── Server 3
```

Because requests are independent, different servers can handle different requests.

---

# 8. Client-Server Separation

REST separates the responsibilities of the client and server.

### Client

Responsible for:

- Sending requests
- Displaying results
- User interface
- Client-side logic

### Server

Responsible for:

- Processing requests
- Business logic
- Database interaction
- Returning data

Example:

```text
Python / Web App
      ↓
    REST API
      ↓
   Database
```

The Python application doesn't need to know how the database is internally structured.

It only needs to understand the API.

---

# 9. Request/Response Model

REST APIs generally use the HTTP request/response model.

### Request

```text
Client
   ↓
HTTP Request
   ↓
Server
```

A request can contain:

```text
Method
URL
Headers
Parameters
Body
```

Example:

```python
response = requests.get(
    "https://jsonplaceholder.typicode.com/users"
)
```

---

### Response

The server sends something back:

```text
Server
   ↓
HTTP Response
   ↓
Client
```

A response commonly contains:

```text
Status Code
Headers
Body
```

Example:

```python
print(response.status_code)

data = response.json()
```

---

# 10. REST + HTTP

REST APIs commonly use HTTP methods to operate on resources.

For example:

```text
GET    /products
POST   /products
PUT    /products/10
PATCH  /products/10
DELETE /products/10
```

The **REST concept** tells us to think in terms of resources.

The **HTTP method** tells us what operation we're requesting.

Detailed HTTP methods and status codes will be covered in:

```text
03_HTTP_Methods_Status_Codes
```

---

# 11. REST API Example

Imagine an e-commerce API.

Resources:

```text
/customers
/products
/orders
```

Specific resources:

```text
/customers/105
/products/20
/orders/5001
```

A client could request:

```text
GET /products
```

The server might return:

```json
[
    {
        "id": 1,
        "name": "Laptop",
        "price": 75000
    },
    {
        "id": 2,
        "name": "Mouse",
        "price": 1200
    }
]
```

The client doesn't need to know whether the server obtained this information from:

```text
PostgreSQL
MySQL
MongoDB
CSV
Another API
```

The API hides those implementation details.

---

# 12. REST Principles You Need

For AI/ML/data work, focus on these:

### 1. Resource-oriented

APIs expose resources:

```text
/users
/products
/orders
```

### 2. Stateless

Each request should contain the information required to process it.

### 3. Client-server separation

Client and server have separate responsibilities.

### 4. HTTP request/response

Communication happens through requests and responses.

### 5. Standard HTTP behavior

REST APIs commonly use HTTP methods, status codes, headers, URLs, and JSON.

---

# 13. REST API Mental Model

Keep this model in your head:

```text
             REST API
                │
        ┌───────┴───────┐
        │               │
    Resources       HTTP
        │               │
   /users           GET
   /products        POST
   /orders          PUT
                    PATCH
                    DELETE
        │
        ↓
 Request → Server → Response
```

---

# 14. Common Mistakes

### Mistake 1 — Thinking REST is a programming language

REST is **not** a programming language.

It is an architectural style/principles for designing APIs.

---

### Mistake 2 — Thinking REST means JSON

REST APIs commonly return JSON, but REST itself does **not require JSON**.

An API could technically return other representations.

---

### Mistake 3 — Thinking the API is the database

The API is an interface between the client and backend systems.

```text
Python
   ↓
API
   ↓
Backend
   ↓
Database
```

---

### Mistake 4 — Thinking stateless means the server stores nothing

Statelessness means the server doesn't rely on **previous request state** to understand the current request.

It does **not** mean the server has no database or persistent data.

---

# 15. AI/ML Relevance

REST APIs are extremely useful in AI/ML workflows.

For example:

```text
Public API
    ↓
Python requests
    ↓
JSON
    ↓
Data cleaning
    ↓
Pandas DataFrame
    ↓
Feature Engineering
    ↓
ML Model
```

You may collect:

- Weather data
- Financial data
- Product data
- Customer data
- Social/media data
- LLM responses
- ML predictions

through REST APIs.

---

## Key Takeaway

Remember this:

> **REST is a way of designing APIs around resources, using a stateless client-server request/response model.**

Example:

```text
Client
   ↓
GET /products/10
   ↓
REST API
   ↓
Server
   ↓
JSON Response
   ↓
Client
```