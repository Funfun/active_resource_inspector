# turns everything into the same object
class AddressXMLFormatter
  include ActiveResource::Formats::XmlFormat

  def decode(xml)
    data = ActiveResource::Formats::XmlFormat.decode(xml)
    # process address fields
    data.each do |address|
      address['city_state'] = "#{address['city']}, #{address['state']}"
    end
    data
  end

end

class AddressResource < ActiveResource::Base
  self.element_name = "address"
  self.format = AddressXMLFormatter.new
  self.site = 'http://37s.sunrise.i:3000'
  site.user = 'foo'
  site.password = 'bar'
end
