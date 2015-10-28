$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'active_resource_inspector'
require 'active_resource'
Dir[File.join('./spec/fixtures', '**/*.rb')].each{|f| require f }
