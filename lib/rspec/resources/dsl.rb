# frozen_string_literal: true

require 'rspec/resources/dsl/actions'
require 'rspec/resources/dsl/characteristics'
require 'rspec/resources/dsl/matchers'

module RSpec
  module Resources
    module DSL
      # Custom describe block that sets metadata to enable easy resource testing.
      # This directly correlates with the `resources` directive of the rails routes file.
      #
      #   describe_resources '/v1/articles', meta: :data do
      #     # ...
      #   end
      #
      # Params:
      # +base_path+:: The resources base path, typically the one of the index action
      # +options+:: RSpec's `describe` metadata arguments
      # +block+:: Block to pass into describe
      #
      def describe_resources(base_path, options = {}, &block)
        abstract_describe(base_path, { single_resource: false }.merge(options), &block)
      end

      # Custom describe block that sets metadata to enable easy resource testing.
      # In contrast to `#describe_resources` this method is meant for resources where only one instance exists.
      # This directly correlates with the `resource` directive of the rails routes file.
      #
      #   describe_resources '/v1/profile', meta: :data do
      #     # ...
      #   end
      #
      # Params:
      # +base_path+:: The resource base path, typically the one of the get action
      # +options+:: RSpec's `describe` metadata arguments
      # +block+:: Block to pass into describe
      #
      def describe_resource(base_path, options = {}, &block)
        abstract_describe(base_path, { single_resource: true }.merge(options), &block)
      end

      private

      def abstract_describe(base_path, options = {}, &block)
        name = base_path.split('/').last

        dopts = {
          type: :request,
          base_path: base_path,
          resource_name: name.singularize,
          rspec_resources_dsl: :resource,
        }.merge(options)

        RSpec.describe(name.capitalize, dopts) do
          let(:request_headers) do |current_example|
            (current_example.metadata[:request_headers] || []).map { |s| send s }.inject { |x, y| x.merge y }
          end

          instance_eval(&block)
        end
      end
    end
  end
end

RSpec::Core::ExampleGroup.extend(RSpec::Resources::DSL)
RSpec::Core::DSL.expose_example_group_alias(:describe_resources)
RSpec::Core::DSL.expose_example_group_alias(:describe_resource)

RSpec.configuration.include RSpec::Resources::DSL::Actions, rspec_resources_dsl: :resource
RSpec.configuration.include RSpec::Resources::DSL::Characteristics, rspec_resources_dsl: :resource
RSpec.configuration.include RSpec::Resources::DSL::Matchers, rspec_resources_dsl: :resource
# RSpec.configuration.backtrace_exclusion_patterns << %r{lib/rspec/resources/dsl/}
