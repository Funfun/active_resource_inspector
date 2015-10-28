require 'active_support/core_ext/string/inflections'
require "active_resource_inspector/version"
require 'active_resource_inspector/railtie' if defined?(Rails::Railtie)

module ActiveResourceInspector
  class Base
    attr_reader :resources
    attr_accessor :dirname

    def resources
      @resources ||= files.map do |file|
        filename = file.split(dirname).last.gsub('.rb', '')
        klass = filename.camelize.constantize
        next if klass.class == Module
        if ActiveResource::Base == klass.superclass && klass.site.present?
          klass
        else
          next
        end
      end.compact
    end

    def files
      Dir[File.join(dirname, '**/*.rb')]
    end

    def self.print(dirpath)
      factory(dirpath).defaul_print
    end

    def self.detailed_print
      factory(dirpath).defaul_print do |res|
        ["\t"*5, res.prefix_source, res.collection_name, res.format_extension, " (", res, ") \n\n"].join('')
      end
    end

    def defaul_print(&block)
      puts "Location: #{dirname}"
      puts "\n"
      resources.group_by{|e| e.site.to_s }.each do |endpoint, rs|
        rs.group_by{|e| e.auth_type }.each do |auth_type, rs2|
          if auth_type.nil?
            puts "#{endpoint} #{rs2[0].headers.empty? ? '(no auth)' : 'with headers auth '+rs2[0].headers.to_s }"
          else
            puts "#{endpoint} wiht auth #{auth_type.capitalize}"
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
      end
    end

    private

    def self.factory(dirname)
      Base.new.tap do |obj|
        if defined?(Rails::Railtie)
          obj.dirname = File.join(Rails.root,'app', 'models')
        else
          obj.dirname = dirname || '.'
        end
      end
    end
  end
end
