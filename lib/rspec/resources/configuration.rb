# frozen_string_literal: true

module RSpec
  module Resources
    class Configuration
      def self.add_setting(name, opts = {})
        define_method("#{name}=") { |value| settings[name] = value }
        define_method(name.to_s) do
          if settings.key?(name)
            settings[name]
          elsif opts[:default].respond_to?(:call)
            opts[:default].call(self)
          else
            opts[:default]
          end
        end
      end

      # Specify how the returned document look like
      # See RSpec::Resources::DOCUMENT_FORMATS
      add_setting :document_format, default: :jsonapi

      def settings
        @settings ||= {}
      end
    end
  end
end
