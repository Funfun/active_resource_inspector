require 'active_resource_inspector'

namespace :resources do
  desc "Print ActiveResource entity's paths grouped by endpoint & auth type."
  task :list, [:dirname => :environment] do |t, args|
    ActiveResourceInspector::Base.print(args[:dirname])
  end
  task :detailed_list, [:dirname => :environment] do |t, args|
    ActiveResourceInspector::Base.detailed_print(args[:dirname])
  end

  task :default => [:list]
end
