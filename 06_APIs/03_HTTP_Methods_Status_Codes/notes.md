# BLOCK 3 — HTTP Methods & Status Codes
# HTTP Methods & Status Codes

HTTP methods tell the server **what action we want to perform**.

HTTP status codes tell us **what happened to our request**.

Basic flow:

```text
Python Client
     ↓
HTTP Request
     ↓
API Server
     ↓
HTTP Response
     ↓
Status Code + Data
```

---

## 1. GET

Used to **retrieve/read data**.

Example:

```python
import requests

response = requests.get(
    "https://jsonplaceholder.typicode.com/users"
)

print(response.status_code)
print(response.json())
```

Think:

```text
GET → Give me data
```

Common uses:

- Get all customers
- Get one customer
- Get products
- Search/filter records

---

## 2. POST

Used to **create a new resource**.

Example:

```python
data = {
    "name": "Yuvanesh",
    "email": "yuva@example.com"
}

response = requests.post(
    "https://example.com/users",
    json=data
)
```

Think:

```text
POST → Create something new
```

---

## 3. PUT

Used to **replace/update an existing resource**.

Example:

```python
data = {
    "name": "Yuvanesh",
    "email": "new@example.com"
}

response = requests.put(
    "https://example.com/users/101",
    json=data
)
```

Think:

```text
PUT → Replace/update the resource
```

PUT commonly sends the complete representation of the resource.

---

## 4. PATCH

Used for a **partial update**.

Example:

```python
data = {
    "email": "new@example.com"
}

response = requests.patch(
    "https://example.com/users/101",
    json=data
)
```

Only the email is being changed.

Think:

```text
PATCH → Change part of something
```

### PUT vs PATCH

```text
PUT
 ↓
Replace/update the resource

PATCH
 ↓
Update only specific fields
```

Example:

```text
Customer:
name
email
city
phone
```

If you want to change only:

```text
email
```

`PATCH` is generally appropriate.

---

## 5. DELETE

Used to **delete a resource**.

Example:

```python
response = requests.delete(
    "https://example.com/users/101"
)
```

Think:

```text
DELETE → Remove something
```

---

# HTTP Method Cheat Sheet

| Method | Purpose |
|---|---|
| `GET` | Read/retrieve |
| `POST` | Create |
| `PUT` | Replace/update |
| `PATCH` | Partially update |
| `DELETE` | Delete |
| `HEAD` | Get response headers only |
| `OPTIONS` | Ask what methods/options are supported |

The first five are the important ones for your AI/ML work.

---

# 6. HEAD

`HEAD` is similar to `GET`, but the server returns the **headers without the response body**.

Conceptually:

```text
GET
→ Headers + Body

HEAD
→ Headers only
```

Useful when you only need information about a resource without downloading its complete content.

You only need introductory knowledge.

---

# 7. OPTIONS

`OPTIONS` asks the server what communication methods/options are supported for a resource.

Example:

```python
response = requests.options(url)

print(response.headers)
```

You only need to recognize what `OPTIONS` is used for.

---

# HTTP Status Codes

A status code tells the client the result of the request.

Status codes are grouped into categories:

```text
1xx → Informational
2xx → Success
3xx → Redirection
4xx → Client error
5xx → Server error
```

For your work, focus mainly on **2xx, 4xx, and 5xx**.

---

# 8. 200 — OK

The request succeeded.

Example:

```text
GET /customers/101
        ↓
200 OK
```

Means:

> The server successfully processed the request.

Very common with `GET`.

---

# 9. 201 — Created

The request successfully created a new resource.

Most commonly associated with:

```text
POST
```

Example:

```text
POST /customers
        ↓
201 Created
```

Means:

> The customer was successfully created.

---

# 10. 204 — No Content

The request succeeded, but there is **no response body**.

Example:

```text
DELETE /customers/101
        ↓
204 No Content
```

Important:

```python
response.status_code
```

may be:

```text
204
```

but there may be no JSON to parse.

So don't blindly do:

```python
response.json()
```

on every response.

---

# 11. 400 — Bad Request

The server cannot process the request because the request itself is invalid.

Examples:

```text
Missing required field
Invalid parameter
Malformed request
Invalid JSON
```

Think:

```text
400 → Your request is wrong
```

---

# 12. 401 — Unauthorized

Authentication is missing or invalid.

Examples:

```text
Missing API key
Invalid API key
Expired token
Missing authentication
```

Think:

```text
401 → Who are you?
```

---

# 13. 403 — Forbidden

The server understood who you are, but you **don't have permission**.

Example:

```text
Normal user
     ↓
Admin-only endpoint
     ↓
403 Forbidden
```

Think:

```text
403 → I know who you are,
      but you're not allowed.
```

---

# 14. 404 — Not Found

The requested resource does not exist.

Example:

```text
GET /customers/999999
        ↓
404 Not Found
```

Think:

```text
404 → I can't find it.
```

---

# 15. 409 — Conflict

The request conflicts with the current state of the resource.

Common examples:

```text
Duplicate record
Existing username
Conflicting update
```

Think:

```text
409 → Your request conflicts with existing data/state.
```

---

# 16. 429 — Too Many Requests

The client has sent too many requests in a given period.

Example:

```text
1000 requests
     ↓
API rate limit exceeded
     ↓
429
```

This is especially important when building **data collection pipelines**.

We will study rate limiting and retry logic more deeply in the **API Error Handling** block.

---

# 17. 500 — Internal Server Error

Something went wrong on the server.

```text
Client
  ↓
Request
  ↓
Server ❌
  ↓
500
```

Usually the problem is on the server side rather than with your Python syntax.

---

# 18. 502 — Bad Gateway

A server acting as a gateway/proxy received an invalid response from another upstream server.

Conceptually:

```text
Your client
    ↓
API Gateway
    ↓
Another server ❌
    ↓
502
```

You only need to recognize it.

---

# 19. 503 — Service Unavailable

The server is temporarily unable to handle the request.

Possible reasons:

- Server overload
- Maintenance
- Temporary outage

Example:

```text
API temporarily unavailable
        ↓
503
```

This becomes important when we learn **retry logic and exponential backoff**.

---

# Important Status Code Cheat Sheet

```text
200 → Success
201 → Created
204 → Success, no content

400 → Bad request
401 → Authentication problem
403 → Permission problem
404 → Resource not found
409 → Conflict
429 → Too many requests

500 → Server error
502 → Bad gateway
503 → Service unavailable
```

---

# Method + Status Code Examples

### Reading data

```text
GET /products
      ↓
200 OK
```

### Creating data

```text
POST /products
      ↓
201 Created
```

### Updating data

```text
PATCH /products/10
      ↓
200 OK
```

### Deleting data

```text
DELETE /products/10
      ↓
204 No Content
```

### Invalid request

```text
POST /products
      ↓
400 Bad Request
```

### Missing authentication

```text
GET /products
      ↓
401 Unauthorized
```

### No permission

```text
GET /admin/products
      ↓
403 Forbidden
```

### Resource doesn't exist

```text
GET /products/9999
      ↓
404 Not Found
```

### Too many requests

```text
GET /products
      ↓
429 Too Many Requests
```

### Server problem

```text
GET /products
      ↓
500 Internal Server Error
```

---

# Important Rule

**HTTP method and status code are different things.**

Method:

> What are we asking the server to do?

Status code:

> What happened after we asked?

Example:

```text
PATCH /customers/101
        ↓
      200
```

Means:

```text
PATCH → update part of customer 101
200   → update succeeded
```

---

# AI/ML Data Pipeline Connection

When collecting data from APIs:

```text
Python
   ↓
GET request
   ↓
API
   ↓
Status code
   ↓
Was it successful?
   ↓
JSON response
   ↓
Pandas
   ↓
Data preprocessing
```

Your Python program should **not assume every request succeeds**.

Instead:

```python
response = requests.get(url)

if response.status_code == 200:
    data = response.json()
else:
    print("Request failed:", response.status_code)
```

Later, you'll learn better production-level error handling.

---

# Common Mistakes ⚠️

### Mistake 1

Thinking:

```text
POST = always 201
```

Not necessarily.

The API decides the actual response.

---

### Mistake 2

Calling `.json()` blindly:

```python
data = response.json()
```

Some responses, such as `204`, have no body.

---

### Mistake 3

Confusing `401` and `403`.

```text
401 → Authentication
403 → Permission
```

---

### Mistake 4

Thinking every `5xx` error is caused by your code.

`5xx` generally indicates a **server-side problem**.

---

## Final Mental Model

```text
HTTP METHOD
     ↓
What do I want?

GET      → Read
POST     → Create
PUT      → Replace
PATCH    → Partially update
DELETE   → Delete
HEAD     → Headers only
OPTIONS  → Available options/methods


STATUS CODE
     ↓
What happened?

2xx → Success
4xx → Client/request problem
5xx → Server problem
```
