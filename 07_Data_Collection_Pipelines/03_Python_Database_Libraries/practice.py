from sqlalchemy import create_engine,text
import pandas as pd

engine = create_engine("sqlite:///07_Data_Collection_Pipelines/02_SQL_Connections/database.db")

# 
with engine.connect() as connection:

    result = connection.execute(
        text("SELECT * FROM employees")
    )

    rows = result.fetchall()
    print(rows)

# 
with engine.connect() as connection:

    result = connection.execute(
        text("""SELECT * 
        FROM employees
        WHERE salary > :salary
        """),
        {'salary' : 50000}
    )

    rows = result.fetchall()

    print(rows)

# 

df = pd.read_sql(
    "SELECT* FROM employees",
    engine
)

filt = (df['department'] == 'AI')

print(df.loc[filt])

# 

data = {
    "name": ["Kumar", "Priya", "Vijay"],
    "department": ["AI", "Data", "ML"],
    "salary": [70000, 55000, 65000]
}

df2 = pd.DataFrame(data)

df2.to_sql(
    'new_employees',
    engine,
    if_exists='replace',
    index=False
)

df3 = pd.read_sql(
    "SELECT * FROM new_employees",
    engine
)

print(df3)
