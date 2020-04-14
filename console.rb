require('pry')
require_relative('models/property.rb')


Property.delete_all()

house1 = Property.new( { 'address' => '31 Spooner Street', 'value' => '20000', 'number_of_bedrooms' => '4', 'year_built' => '1998' } )
house1.save()


house2 = Property.new( { 'address' => '37 Castle Terrace', 'value' => '3000000', 'number_of_bedrooms' => '23', 'year_built' => '2004' })
house2.save()

house3 = Property.new( { 'address' => '21 Jump Street', 'value' => '2000', 'number_of_bedrooms' => '12', 'year_built' => '1888' } )
house3.save()

house4 = Property.new( { 'address' => 'Deathstar', 'value' => '1000000', 'number_of_bedrooms' => '10000', 'year_built' => '1979' } )
house4.save()



house2.delete()
house1.number_of_bedrooms = '5'
house1.update()

found = Property.find(house1.id)

houses = Property.all()



binding.pry
nil