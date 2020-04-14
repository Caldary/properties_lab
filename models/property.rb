require ( 'pg' )

class Property

    attr_accessor :address, :value, :number_of_bedrooms, :year_built
    attr_reader :id
    def initialize( options )
        @address = options['address']
        @value = options['value'].to_i
        @number_of_bedrooms = options['number_of_bedrooms'].to_i
        @year_built = options['year_built'].to_i
        @id = options['id'] if options['id']
    end

    def save()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "INSERT INTO properties
            (address,
            value,
            number_of_bedrooms,
            year_built)
            VALUES
            ($1, $2, $3, $4)
            RETURNING *;"
        values = [@address, @value, @number_of_bedrooms, @year_built]
        db.prepare("save", sql)
        @id = db.exec_prepared("save", values)[0]["id"].to_i
        db.close()
    end

    def Property.all()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "SELECT * FROM properties;"
        db.prepare("all", sql)
        properts = db.exec_prepared("all")
        db.close()
        return properts.map {|property| Property.new(property)}
    end

    def Property.delete_all()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "DELETE FROM properties;"
        db.prepare("delete_all", sql)
        db.exec_prepared("delete_all")
        db.close
    end

    def delete()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "DELETE FROM properties
        WHERE id = $1"
        values = [@id]
        db.prepare("delete_one", sql)
        db.exec_prepared("delete_one", values)
        db.close()
    end

    def update()
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "UPDATE properties
        SET
        (
            address,
            value,
            number_of_bedrooms,
            year_built
        ) = ($1, $2, $3, $4
        ) WHERE id = $5"
        values = [@address, @value, @number_of_bedrooms, @year_built, @id]
        db.prepare("update", sql)
        db.exec_prepared("update", values)
        db.close 
    end

    def self.find(id)
        db = PG.connect( { dbname: 'property_tracker', host: 'localhost' } )
        sql = "SELECT * 
                FROM properties 
                WHERE id = $1 "
        values = [id]
        db.prepare("find_value", sql)
        prop = db.exec_prepared("find_value", values)
        return Property.new(prop[0])
    end
    
    
end