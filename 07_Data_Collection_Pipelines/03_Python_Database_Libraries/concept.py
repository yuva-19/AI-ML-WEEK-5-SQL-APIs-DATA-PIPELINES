from sqlalchemy import create_engine, text

engine = create_engine("sqlite:///07_Data_Collection_Pipelines/02_SQL_Connections/database.db")

with engine.connect() as connection:

    result = connection.execute(
        text("SELECT * FROM employees")
    )

    rows = result.fetchall()

    print(rows)


import pandas as pd
from sqlalchemy import create_engine

# 1. Create engine
engine = create_engine("sqlite:///07_Data_Collection_Pipelines/03_Python_Database_Libraries/database.db")

# 2. Create DataFrame
df = pd.DataFrame({
    "name": ["Yuva", "Arun", "Ravi"],
    "department": ["AI", "Data", "ML"],
    "salary": [50000, 45000, 60000]
})

# 3. Write DataFrame to database
df.to_sql(
    "employees",
    engine,
    if_exists="replace",
    index=False
)

# 4. Read database into DataFrame
df2 = pd.read_sql(
    "SELECT * FROM employees",
    engine
)

print(df2)