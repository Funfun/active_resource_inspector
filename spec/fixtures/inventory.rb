class Inventory < ActiveResource::Base
  include ActiveResource::Singleton
  self.site = 'http://37s.sunrise.i:3000'
  self.prefix = '/products/:product_id/'
  self.singleton_name = 'the_inventory'
  self.primary_key = :code

  schema do
    integer :total
    integer :used

    string :status
  end
end
