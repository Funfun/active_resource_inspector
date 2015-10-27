require 'active_resource_inspector'

namespace :resources do
  desc "Print ActiveResource entity's paths grouped by endpoint & auth type."
  task list: :environment do
    ActiveResourceInspector.run
  end
  task detailed_list: :environment do
    ActiveResourceInspector.run(:detailed_print)
  end

  task :default => [:list]
end
