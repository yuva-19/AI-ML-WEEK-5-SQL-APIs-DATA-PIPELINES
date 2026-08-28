# Configuration Management

Configuration management is the practice of **separating application configuration from application code**.

Configuration may include:

- API keys
- Database passwords
- Database host and port
- File paths
- Batch sizes
- Retry counts
- Environment-specific settings

---

## 1. Why Avoid Hardcoding?

❌ Avoid:

```python
connection = psycopg.connect(
    host="localhost",
    dbname="practice_sql",
    user="postgres",
    password="my_password",
    port=5432
)
```

### Problems

- Secrets can accidentally be uploaded to GitHub.
- Configuration changes require modifying the code.
- Different environments may require different settings.
- Credentials become exposed in the source code.

---

# 2. Environment Variables

An **environment variable** is a value stored outside the application code that can be accessed by the program at runtime.

Example:

```text
DB_HOST=localhost
DB_NAME=practice_sql
DB_USER=postgres
DB_PASSWORD=your_password
DB_PORT=5432
```

Python can access environment variables using `os`:

```python
import os

password = os.getenv("DB_PASSWORD")
```

---

# 3. `.env` File

A `.env` file is commonly used during local development to store environment variables.

Example:

```text
DB_HOST=localhost
DB_NAME=practice_sql
DB_USER=postgres
DB_PASSWORD=your_password
DB_PORT=5432
```

Python can load these values using `python-dotenv`:

```python
from dotenv import load_dotenv
import os

load_dotenv()

password = os.getenv("DB_PASSWORD")
```

---

# 4. PostgreSQL With `.env`

Instead of putting credentials directly in Python:

```python
connection = psycopg.connect(
    host=os.getenv("DB_HOST"),
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    port=os.getenv("DB_PORT")
)
```

The credentials remain in `.env`, while the Python code contains only the logic for accessing them.

---

# 5. `.gitignore`

`.env` normally should **not be committed to GitHub** because it may contain secrets.

Add this to `.gitignore`:

```text
.env
```

Example project:

```text
project/
│
├── main.py
├── .env
├── .gitignore
└── requirements.txt
```

`.gitignore` tells Git not to track specified files.

---

# 6. Configuration vs Application Logic

### Without configuration management

```text
Python Code
│
├── API Key
├── Password
├── Database Host
├── File Path
└── Application Logic
```

### With configuration management

```text
Python Code
│
└── Application Logic

Configuration
│
├── API Key
├── Password
├── Database Host
└── File Path
```

This makes applications easier to maintain and deploy.

---

# 7. Environment-Specific Configuration

Applications commonly have different environments:

```text
Development
Testing
Production
```

For example:

```text
Development:
DB_HOST=localhost

Production:
DB_HOST=production-server
```

The application code can remain the same while the configuration changes.

---

# 8. Configuration for File Paths

Paths can also be stored as configuration.

Example:

```text
DATA_PATH=data/customers.csv
```

Python:

```python
import os
import pandas as pd

path = os.getenv("DATA_PATH")

df = pd.read_csv(path)
```

This avoids hardcoding paths throughout the application.

---

# 9. YAML Configuration

**YAML** is a human-readable configuration format.

Example:

```yaml
database:
  host: localhost
  port: 5432
  name: practice_sql

pipeline:
  batch_size: 1000
  retry_count: 3
```

YAML can store structured configuration in a readable format.

For the current roadmap, only an **introduction to YAML configuration** is required.

---

# 10. Common Configuration Values

```text
API keys
Database passwords
Database host
Database port
Database name
File paths
Batch sizes
Retry counts
Environment names
Model parameters
```

---

# Key Takeaways

- **Configuration management** separates configuration from application logic.
- **Environment variables** store values outside the Python source code.
- **`.env`** is commonly used to store local environment variables.
- `os.getenv()` retrieves environment variables in Python.
- `.env` should normally be added to `.gitignore`.
- Database passwords and API keys should **not be hardcoded**.
- The same application code can use different configurations for development, testing, and production.
- **YAML** is another format for storing structured configuration.
- Secrets should remain outside source code and version control.

> **Core idea:** Keep **application logic in code** and keep **configuration and secrets outside the code**.