from flask import Flask
from extensions import db
from db_config import SQLALCHEMY_DATABASE_URI, SQLALCHEMY_TRACK_MODIFICATIONS
from routes import user_bp

app = Flask(__name__)
app.secret_key = 'supersecretkey'

# SQLAlchemy Configuration
app.config['SQLALCHEMY_DATABASE_URI'] = SQLALCHEMY_DATABASE_URI
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = SQLALCHEMY_TRACK_MODIFICATIONS
db.init_app(app)

# Register all routes
app.register_blueprint(user_bp)

if __name__ == '__main__':
    app.run(debug=True)
