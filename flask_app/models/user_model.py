from flask_app.config.mysqlconnection import connectToMySQL
from flask import flash, session
import re



EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$')


class User:
    DB = "pawsome_forum"

    def __init__(self, data):
        self.id=data['id']
        self.username = data['username']
        self.email = data.get('email')
        self.password = data['password']


    @classmethod
    def create_user(cls, data):

        query = """INSERT INTO users 
        (username, email, password)
        VALUES 
        (%(username)s, %(email)s, %(password)s);"""

        db = connectToMySQL(cls.DB)
        user_id = db.query_db(query, data)
        return user_id
    
    @classmethod
    def get_all_users(cls):
        query = "SELECT * FROM users;"
        results = connectToMySQL(cls.DB).query_db(query)
        users = []
        for user in results:
            users.append(cls(user))
        return users
    
    @classmethod
    def get_one_by_id(cls, user_id):
        query  = "SELECT * FROM users WHERE id = %(id)s";
        data = {'id':user_id}
        results = connectToMySQL(cls.DB).query_db(query, data)
        return cls(results[0])
    
    @classmethod
    def get_one_by_email(cls,data):
        query = "SELECT * FROM users WHERE email = %(email)s;"
        result = connectToMySQL(cls.DB).query_db(query,data)
        if len(result) < 1:
            return None
        return cls(result[0])
    
    # @classmethod
    # def get_user_by_username(cls, username):
    #     query = "SELECT id FROM users WHERE username = %(username)s;"
    #     data = {'username': username}
    #     result = connectToMySQL(cls.DB).query_db(query, data)
    #     return result[0]['id'] if result else None
    
    @staticmethod
    def new_user_validation(data):
        is_valid = True
        query_email = "SELECT * FROM users WHERE email = %(email)s;"
        results_email = connectToMySQL(User.DB).query_db(query_email, data)
        query_username = "SELECT * FROM users where username=%(username)s;"
        results_username = connectToMySQL(User.DB).query_db(query_username, data)
        if not EMAIL_REGEX.match(data['email']):
            flash("Invalid email address", 'create')
            is_valid = False
        if len(results_email) >= 1:
            flash("Email already exists", 'create')
            is_valid = False
        if len(data['username']) < 1 or not data['username'].isalnum():
            flash("Username must be between 1 and 15 alphanumeric characters", 'create')
            is_valid = False
        if len(results_username) >= 1:
            flash("Username already exists", 'create')
            is_valid = False
        if len(data['password']) < 8:
            flash("Password must be at least 8 characters", 'create')
            is_valid = False
        if data['password'] != data['confirm_password']:
            flash("Passwords must match", 'create')
            is_valid = False
        return is_valid