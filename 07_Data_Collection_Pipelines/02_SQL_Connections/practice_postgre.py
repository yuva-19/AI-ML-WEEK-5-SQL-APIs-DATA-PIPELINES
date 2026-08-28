# Q3 using the Postegre SQL
import psycopg
import pandas as pd
import os
import psycopg
from dotenv import load_dotenv

connection = psycopg.connect(
    host=os.getenv("DB_HOST"),
    dbname=os.getenv("DB_NAME"),
    user=os.getenv("DB_USER"),
    password=os.getenv("DB_PASSWORD"),
    port=int(os.getenv("DB_PORT"))
)

print('Connection is Successful!!')

cursor = connection.cursor()

cursor.execute("""
SELECT * FROM customers
""")

customers = cursor.fetchall()


df = pd.DataFrame(
    customers,
    columns=['id','first_name','last_name','email','city','signup_date']
)

print(df)

connection.close()