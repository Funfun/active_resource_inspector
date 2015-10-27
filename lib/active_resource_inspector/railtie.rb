module ActiveResourceInspector
  require 'rails'

  class Railtie < Rails::Railtie
    rake_tasks { load "tasks/resources.rake" }
  end
end
