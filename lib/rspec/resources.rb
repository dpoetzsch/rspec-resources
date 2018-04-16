# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/object'

require 'rspec'

require 'rspec/resources/document_formats'
require 'rspec/resources/configuration'
require 'rspec/resources/util'
require 'rspec/resources/dsl'
require 'rspec/resources/version'

module RSpec
  module Resources
    def self.configuration
      @configuration ||= Configuration.new
    end

    # Configures rspec-resources
    #
    # See RSpec::Resources::Configuration for more information on configuring.
    #
    #   RSpec::Resources.configure do |config|
    #     config.document_format = :jsonapi
    #   end
    def self.configure
      yield configuration if block_given?
    end
  end
end
