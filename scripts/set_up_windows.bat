@echo off
REM Setup script for Windows

echo Creating virtual environment...
python -m venv .venv

echo Activating virtual environment...
call .venv\Scripts\activate

echo Installing dependencies...
pip install -r requirements.txt

echo Starting Docker containers...
docker-compose up -d

REM Wait for MySQL to fully initialize
echo Waiting for MySQL to initialize...
timeout /t 10 >nul

REM Loading environment variables from .env
echo Loading environment variables from .env...
for /f "tokens=*" %%i in (.env) do set %%i

REM Create MySQL user and database if not existing
echo Creating MySQL user and database...
docker exec studentsignup-mysql-1 mysql -uroot -p%MYSQL_ROOT_PASSWORD% -e ^
"CREATE DATABASE IF NOT EXISTS %MYSQL_DATABASE%; ^
CREATE USER IF NOT EXISTS '%MYSQL_USER%'@'%%' IDENTIFIED BY '%MYSQL_PASSWORD%'; ^
GRANT ALL PRIVILEGES ON %MYSQL_DATABASE%.* TO '%MYSQL_USER%'@'%%'; ^
FLUSH PRIVILEGES;"

echo Running DB table creation script...
docker exec studentsignup-mysql-1 mysql -u$MYSQL_USER -p$MYSQL_PASSWORD $MYSQL_DATABASE < create_table.sql

echo Running Flask app...
flask run

eecho Setup complete. To activate your environment later, run: call .venv\Scripts\activate