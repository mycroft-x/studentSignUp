from extensions import db
from models import User

def save_user(user):
    db.session.add(user)
    db.session.commit()

def get_all_users():
    return User.query.all()

def get_user_by_username(username):
    return User.query.filter_by(username=username).first()