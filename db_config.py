from dotenv import load_dotenv
import os

# Load environment variables
load_dotenv()

# Database connection info
MYSQL_USER = os.getenv('MYSQL_USER')
MYSQL_PASSWORD = os.getenv('MYSQL_PASSWORD')
MYSQL_HOST = os.getenv("MYSQL_HOST")
MYSQL_PORT=os.getenv('MYSQL_PORT')
MYSQL_DB = os.getenv('MYSQL_DATABASE')

# SQLAlchemy URI
SQLALCHEMY_DATABASE_URI = f'mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}/{MYSQL_DB}'
SQLALCHEMY_TRACK_MODIFICATIONS = False