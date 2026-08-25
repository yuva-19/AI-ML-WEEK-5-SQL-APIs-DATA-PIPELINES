# BLOCK 6 — API AUTHENTICATION 🔐

## 1. What is API Authentication?

When we send a request to an API, the server may need to verify **who is making the request** and whether they are allowed to access the requested resource.

This process is called **authentication**.

Example:

```text
Python Application
       ↓
   API Request
       ↓
 Authentication
       ↓
     Server
       ↓
 Allow / Reject
```

Without authentication, some APIs may reject requests or provide only public data.

Authentication is very common when working with:

- SaaS APIs
- Cloud APIs
- Payment APIs
- LLM APIs
- ML services
- Internal company APIs

---

# 2. API Keys

An **API key** is a secret value provided by an API service to identify your application or account.

Example:

```text
demo_key_123456
```

The API documentation tells you **where and how to send the key**.

A common method is through a request header.

### Example

```python
import requests

api_key = "YOUR_API_KEY"

headers = {
    "X-API-Key": api_key
}

response = requests.get(
    "https://api.example.com/products",
    headers=headers
)

print(response.status_code)
```

Here:

```python
headers = {
    "X-API-Key": api_key
}
```

means:

> Send the API key as part of the request headers.

---

## Important: Header Name Depends on the API

There is **no universal header name for every API key**.

An API might require:

```text
X-API-Key
```

or:

```text
api-key
```

or another documented format.

Therefore:

> **Always check the API documentation for the required authentication format.**

Don't randomly assume the header name.

---

# 3. Bearer Tokens

Another common authentication method is a **Bearer Token**.

A token is a credential that the API gives to your application.

Example:

```text
demo_token_456789
```

The standard format is usually:

```text
Authorization: Bearer <token>
```

### Python

```python
import requests

token = "YOUR_TOKEN"

headers = {
    "Authorization": f"Bearer {token}"
}

response = requests.get(
    "https://api.example.com/orders",
    headers=headers
)

print(response.status_code)
```

The important part is:

```python
"Authorization": f"Bearer {token}"
```

If:

```python
token = "abc123"
```

the header becomes conceptually:

```text
Authorization: Bearer abc123
```

---

# 4. API Key vs Bearer Token

Both are used to authenticate API requests, but their usage differs.

| API Key | Bearer Token |
|---|---|
| Usually identifies an application/account | Usually represents an access token |
| Header format depends on API | Commonly uses `Authorization` |
| Often simple to use | Common in authenticated applications |
| Header name varies | Usually `Bearer <token>` |

For this stage, you **do not need to become an authentication/security expert**.

You mainly need to know:

```text
API Key
    ↓
Header

Bearer Token
    ↓
Authorization Header
```

---

# 5. Authentication Is Usually Sent in Headers

Remember from the previous block that an HTTP request can contain different components.

For example:

```python
response = requests.get(
    url,
    params=params,
    headers=headers
)
```

Here:

### `params`

Specifies **what data you're requesting/filtering**.

Example:

```python
params = {
    "city": "Chennai"
}
```

### `headers`

Contains additional request information, including authentication.

Example:

```python
headers = {
    "X-API-Key": api_key
}
```

So:

```text
GET request
│
├── URL
│
├── Query Parameters
│      └── city = Chennai
│
└── Headers
       └── X-API-Key = ...
```

These are **different concepts**.

---

# 6. Combining Authentication with Parameters

Real API requests commonly use both.

```python
import requests

api_key = "YOUR_API_KEY"

headers = {
    "X-API-Key": api_key
}

params = {
    "city": "Chennai"
}

response = requests.get(
    "https://api.example.com/customers",
    headers=headers,
    params=params
)

print(response.status_code)
print(response.url)
```

The request conceptually becomes:

```text
GET /customers?city=Chennai

Headers:
X-API-Key: YOUR_API_KEY
```

So:

```text
params → controls/request data
headers → request metadata + authentication
```

---

# 7. Never Hard-Code Real API Keys 🚨

During learning, you might write:

```python
api_key = "demo_key_123"
```

That's fine because it's fake.

But **never put real credentials directly into code**.

❌ Bad:

```python
api_key = "sk-real-secret-key-123456"
```

If you upload this file to GitHub, someone could potentially obtain your credential.

This is especially important for:

- OpenAI/LLM APIs
- AWS
- Google Cloud
- Azure
- Database credentials
- Payment APIs
- Company internal APIs

---

# 8. Environment Variables

A better approach is to store secrets outside your Python source code.

For example, create a `.env` file:

```text
API_KEY=your_real_api_key
```

Then Python can read it.

First install:

```bash
pip install python-dotenv
```

Then:

```python
import os
from dotenv import load_dotenv

load_dotenv()

api_key = os.getenv("API_KEY")
```

Now:

```python
headers = {
    "X-API-Key": api_key
}
```

The flow becomes:

```text
.env
 │
 │ API_KEY
 ↓
load_dotenv()
 ↓
os.getenv()
 ↓
Python variable
 ↓
Request header
 ↓
API
```

---

# 9. Why `.env` Is Useful

Suppose your Python code is:

```python
api_key = os.getenv("API_KEY")

headers = {
    "X-API-Key": api_key
}
```

The actual secret isn't visible in the Python file.

This is useful when:

- Sharing code
- Using Git
- Working on team projects
- Deploying applications
- Switching between development and production environments

---

# 10. `.gitignore`

Even if you use a `.env` file, you should normally prevent Git from tracking it.

Add:

```text
.env
```

to:

```text
.gitignore
```

So the basic structure becomes:

```text
project/
│
├── main.py
├── .env
└── .gitignore
```

`.gitignore`:

```text
.env
```

This helps prevent accidentally committing your secrets.

---

# 11. OAuth 2.0 — Introduction

**OAuth 2.0** is an authorization framework commonly used when an application needs access to resources on behalf of a user.

For example, imagine an application wants permission to access some user's account data.

Conceptually:

```text
User
 ↓
Authorization
 ↓
Access Token
 ↓
Application
 ↓
API
```

You don't need to implement OAuth 2.0 yet.

For this roadmap, remember:

> **OAuth 2.0 is commonly used for delegated access to APIs.**

You will encounter it when reading API documentation for larger services.

---

# 12. JWT — Introduction

**JWT** stands for **JSON Web Token**.

It is a token format commonly used for authentication and authorization.

You may encounter a request such as:

```text
Authorization: Bearer <JWT>
```

A JWT generally contains encoded information about the token/session and is digitally signed.

For this stage, you don't need to learn how to build JWT authentication systems.

Just understand:

```text
JWT
 ↓
Token
 ↓
Often sent as
Authorization: Bearer <token>
```

---

# 13. Authentication Failure

If authentication is missing or incorrect, the API may reject the request.

For example:

```text
401 Unauthorized
```

usually means the request lacks valid authentication credentials.

Another possible response:

```text
403 Forbidden
```

usually means the server understood the request/authentication but the client **doesn't have permission** to access that resource.

Remember the basic distinction:

```text
401 → Authentication problem
403 → Permission problem
```

---

# 14. Practical API Authentication Pattern

A common Python pattern looks like this:

```python
import requests
import os

api_key = os.getenv("API_KEY")

headers = {
    "X-API-Key": api_key
}

response = requests.get(
    "https://api.example.com/products",
    headers=headers,
    timeout=10
)

print(response.status_code)

if response.status_code == 200:
    data = response.json()
    print(data)
```

The important workflow is:

```text
Get credential
      ↓
Create headers
      ↓
Send request
      ↓
Check status
      ↓
Process response
```

---

# 15. What You Need to Know for AI/ML Work

You don't need deep security knowledge here.

You should be comfortable with:

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

### Environment Variables

```python
api_key = os.getenv("API_KEY")
```

### Combining Authentication + Parameters

```python
requests.get(
    url,
    headers=headers,
    params=params
)
```

### Security Habit

**Never commit real API credentials to GitHub.**

---

## 🔥 Final Mental Model

When you work with an authenticated API:

```text
                API
                 ↑
            HTTP Request
                 ↑
        ┌────────┴────────┐
        │                 │
    Headers            Parameters
        │                 │
 Authentication       Data filters
        │
 ┌──────┴──────┐
 │             │
API Key     Bearer Token
```

And in a production-style Python program:

```text
.env
 ↓
Environment Variable
 ↓
Authentication Header
 ↓
requests.get()
 ↓
API
 ↓
JSON Response
 ↓
Data Processing
```