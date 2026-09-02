import os
from pathlib import Path
from urllib.parse import quote_plus

from dotenv import load_dotenv
from sqlalchemy import create_engine


# Find the NYC Taxi project root
BASE_DIR = Path(__file__).resolve().parent.parent

print("Project folder:", BASE_DIR)


# Load the .env file from this project
ENV_PATH = BASE_DIR / ".env"

print("Looking for .env at:", ENV_PATH)
print("Does .env exist?", ENV_PATH.exists())

load_dotenv(ENV_PATH, override=True)


# Get database credentials from .env
DB_USER = os.getenv("DB_USER")
DB_PASSWORD = os.getenv("DB_PASSWORD")
DB_HOST = os.getenv("DB_HOST")
DB_PORT = os.getenv("DB_PORT")
DB_NAME = os.getenv("DB_NAME")


# Check which database is being used
print("Database:", DB_NAME)
print("Host:", DB_HOST)
print("Port:", DB_PORT)
print("User:", DB_USER)


# Create PostgreSQL connection URL
DATABASE_URL = (
    f"postgresql+psycopg2://{DB_USER}:{quote_plus(DB_PASSWORD)}"
    f"@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)


# Create SQLAlchemy engine
engine = create_engine(DATABASE_URL)

print("Database connection created successfully")