#!/bin/bash

# Setup script for macOS/Linux

echo "Creating virtual environment..."
python3 -m venv .venv

echo "Activating virtual environment..."
source .venv/bin/activate

echo "Installing dependencies..."
pip install -r requirements.txt

echo "Starting Docker containers..."
docker-compose up -d

# Wait for MySQL to be fully up and running
echo "Waiting for MySQL to initialize..."
sleep 10

# Load environment variables from .env
echo "Loading environment variables from .env..."
set -o allexport
source .env
set +o allexport

# Create MySQL user and database if not existing
echo "Creating MySQL user and database..."
docker exec studentsignup-mysql-1 mysql -uroot -p$MYSQL_ROOT_PASSWORD -e \
"CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE;
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';
GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%';
FLUSH PRIVILEGES;"            

echo "Running DB table creation script..."
docker exec studentsignup-mysql-1 mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < create_table.sql


echo "Running Flask app..."
flask run

echo "Setup complete. Now run: source .venv/bin/activate" to activate your virtual evnironment later
