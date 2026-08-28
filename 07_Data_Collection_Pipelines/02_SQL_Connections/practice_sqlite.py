# Q1

import sqlite3

connection = sqlite3.connect(
    "07_Data_Collection_Pipelines/02_SQL_Connections/database.db"
)
cursor = connection.cursor()

cursor.execute("""
CREATE TABLE IF NOT EXISTS employees (
    id INTEGER PRIMARY KEY,
    name TEXT,
    department TEXT,
    salary INTEGER
)
""")

employees = [
    (1, "Yuva", "AI", 50000),
    (2, "Arun", "Data", 45000),
    (3, "Ravi", "AI", 60000),
    (4, "Karthik", "ML", 55000)
]

cursor.executemany(
    "INSERT INTO employees VALUES (?, ?, ?, ?)",
    employees
)

connection.commit()

cursor.execute("SELECT * FROM employees")

rows = cursor.fetchall()

print(rows)

connection.close()

# Q2

import sqlite3
import pandas as pd

connection = sqlite3.connect("07_Data_Collection_Pipelines/02_SQL_Connections/database.db")
cursor = connection.cursor()

cursor.execute("""
SELECT *
FROM employees
WHERE salary > 50000
""")

high_salary = cursor.fetchall()

df = pd.DataFrame(
    high_salary,
    columns=["id", "name", "department", "salary"]
)
print(df)

cursor.execute(""" 
SELECT * 
FROM employees
WHERE department == 'AI' 
""")

AI_Deparment = cursor.fetchall()

df1 = pd.DataFrame(
    AI_Deparment,
    columns=['id','name','department','salary']
)

print(df1)

connection.close()

