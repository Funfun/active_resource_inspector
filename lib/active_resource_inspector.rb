require "active_resource_inspector/version"
require 'active_resource_inspector/railtie' if defined?(Rails::Railtie)

module ActiveResourceInspector
  def self.run(type = nil)
    Base.new.send(type || :short_print)
  end

  class Base
    def initialize
      @dirname = File.join(Rails.root,'app', 'models')
      models = Dir[File.join(Rails.root,'app', 'models', '**/*.rb')].select{|res| res.match(/concerns/).nil? }
      filtered_models = models.select do |res|
        filename = File.basename(res, '.rb')
        next if filename.downcase.match(/abstract/)

        klass = filename.camelize.constantize
        ActiveResource::Base == klass.superclass
      end
      @resources = filtered_models.sort.map do |res|
        dir, _ = File.split(res)
        filename = File.basename(res, '.rb')
        basedir = dir.split('/').last
        if  'models' == basedir
          filename.camelize.constantize
        else
          "#{basedir}/#{filename}".camelize.constantize
        end
      end
    end

    def short_print
      defaul_print
    end

    def detailed_print
      defaul_print do |res|
        ["\t"*5, res.prefix_source, res.collection_name, res.format_extension, " (", res, ") \n\n"].join('')
      end
    end

    def example_print
      # TO-DO:
      # set random numbers
      # /api/v1/shops/12/publishers/4.json
    end

    private

    def defaul_print(&block)
      puts "\nActiveResource Introspection"
      puts "\nPrint ActiveResource entity's paths grouped by endpoint & auth type."
      puts "\nLocation: #{@dirname}"
      puts "\n"
      @resources.group_by{|e| e.site.to_s }.each do |endpoint, rs|
        rs.group_by{|e| e.auth_type }.each do |auth_type, rs2|
          if auth_type.nil?
            puts "#{endpoint} #{rs2[0].headers.empty? ? '(no auth)' : 'via '+rs2[0].headers.to_s }"
          else
            puts "#{endpoint} via #{auth_type.capitalize}"
          end
          t = rs2.map do |res|
            if block_given?
              block.call(res)
            else
              ["\t"*5, res.prefix_source, res.collection_name, res.format_extension].join('')
            end
          end
          puts t.sort
        end
        puts '-'*120
      end
    end
  end
end
