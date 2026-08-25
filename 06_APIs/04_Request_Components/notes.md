# BLOCK 4 — Request Components

## 1. Main Request Components

```text
API Request
│
├── URL
├── Path Parameters
├── Query Parameters
├── Headers
├── Body
└── Cookies
```

---

## 2. Path Parameters

Used to identify a **specific resource**.

```text
/users/5
/products/10
/orders/25
```

Python:

```python
user_id = 5

response = requests.get(
    f"https://example.com/users/{user_id}"
)
```

**Think:**

> Path → **Which resource?**

---

## 3. Query Parameters

Used for **filtering, searching, sorting, pagination, or options**.

```python
params = {
    "username": "Bret"
}

response = requests.get(
    "https://example.com/users",
    params=params
)
```

Produces:

```text
/users?username=Bret
```

Multiple parameters:

```python
params = {
    "username": "Bret",
    "email": "test@example.com"
}
```

**Think:**

> Query → **What filter/options?**

Useful for debugging:

```python
print(response.url)
```

---

## 4. Path vs Query

```text
/users/5
     ↑
Path → specific user

/users?city=London
       ↑
Query → filter users
```

**Memory:**

```text
PATH  → Which resource?
QUERY → What filter/options?
```

---

## 5. Headers

Carry **metadata/instructions** about the request.

Common headers:

```text
Accept
Content-Type
Authorization
```

Example:

```python
headers = {
    "Accept": "application/json"
}
```

### Important

```text
Accept
→ format I want to receive

Content-Type
→ format I am sending
```

Authentication headers will be covered later.

---

## 6. Request Body

Contains data being sent to the server.

Commonly used with:

```text
POST
PUT
PATCH
```

Example:

```python
data = {
    "name": "Yuvanesh",
    "email": "yuva@example.com"
}

response = requests.post(
    url,
    json=data
)
```

**Think:**

> Body → **What data am I sending?**

---

## 7. Cookies

Small pieces of information sent with requests.

Commonly used for:

- Sessions
- Login state
- User preferences

Introduction only for now.

---

## 8. Common `requests` Patterns

### GET + Query + Headers

```python
response = requests.get(
    url,
    params=params,
    headers=headers
)
```

### POST + JSON + Headers

```python
response = requests.post(
    url,
    headers=headers,
    json=data
)
```

---

## 9. Quick Revision

| Component | Purpose |
|---|---|
| URL | Where to send request |
| Path parameter | Identify specific resource |
| Query parameter | Filter/control request |
| Headers | Request metadata/instructions |
| Body | Data sent to server |
| Cookies | Session-related information |

### Core mental model

```text
URL
 ↓
Path → Which resource?
 ↓
Query → What filter/options?
 ↓
Headers → Extra information
 ↓
Body → Data being sent
```