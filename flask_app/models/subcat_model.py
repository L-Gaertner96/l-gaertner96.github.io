from flask_app import connectToMySQL

class Subcategory:
    
    DB='pawsome_forum'
    
    def __init__(self, id, subcat_name):
        self.id = id
        self.subcat_name = subcat_name

    @classmethod
    def get_subcat_id_by_name(cls, category_id, subcategory_name):
        query = "SELECT id FROM subcategories WHERE categories_id = %(category_id)s AND subcat_name = %(subcategory_name)s;"
        data = {'categories_id': category_id, 'subcat_name': subcategory_name}
        result = connectToMySQL(cls.DB).query_db(query, data)
        return result[0][''] if result else None
    

    @classmethod
    def get_subcat_by_name(cls, category_id, subcategory_name):
        query = "SELECT id, subcat_name FROM subcategories WHERE categories_id = %(category_id)s AND subcat_name = %(subcategory_name)s;"
        data = {'category_id': category_id, 'subcategory_name': subcategory_name}
        result = connectToMySQL(cls.DB).query_db(query, data)
        if result:
            return cls(id=result[0]['id'], subcat_name=result[0]['subcat_name'])
        else:
            return None
