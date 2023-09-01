from flask_app import connectToMySQL
from flask_app.models.subcat_model import Subcategory

class Category:
    DB = 'pawsome_forum'  

    def __init__(self, id, category_name):
        self.id = id
        self.category_name = category_name

    @classmethod
    def get_all_categories(cls):
        query = "SELECT * FROM categories;"
        results = connectToMySQL(cls.DB).query_db(query)
        return [cls(**row) for row in results]

    @classmethod
    def get_category_by_name(cls, category_name):
        query = "SELECT id, category_name FROM categories WHERE category_name = %(category_name)s;"
        data = {'category_name': category_name}
        result = connectToMySQL(cls.DB).query_db(query, data)
        return cls(**result[0]) if result else None
    
    @classmethod
    def get_category_by_id(cls, category_id):
        query = "SELECT id, category_name FROM categories WHERE id = %(category_id)s;"
        data = {'category_id': category_id}
        result = connectToMySQL(cls.DB).query_db(query, data)
        return cls(**result[0]) if result else None


    @classmethod
    def get_subcategories_by_category_id(cls, category_id):
        query = "SELECT id, subcat_name FROM subcategories WHERE categories_id = %(category_id)s;"
        data = {'category_id': category_id}
        results = connectToMySQL(cls.DB).query_db(query, data)
        return [Subcategory(**row) for row in results]

