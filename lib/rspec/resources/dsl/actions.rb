# frozen_string_literal: true

require 'rspec/resources/dsl/actions/include_if_needed'

module RSpec
  module Resources
    module DSL
      module Actions
        extend ActiveSupport::Concern

        module ClassMethods
          def describe_index(&block)
            path = metadata[:base_path]

            describe "GET #{path}" do
              subject { [accessible_resource] }

              before do
                subject # force subject creation
                get instantiate_path(path, subject.first), headers: request_headers
              end

              instance_eval(&block)

              include_if_needed(:index).auth_examples
              include_if_needed(:index).restricted_examples
            end
          end

          def describe_show(&block)
            path = id_path_template

            describe "GET #{path}" do
              subject { accessible_resource }

              before { get instantiate_path(path, subject), headers: request_headers }

              instance_eval(&block)

              include_if_needed(:show).auth_examples
              include_if_needed(:show).restricted_examples
            end
          end

          def describe_create(&block)
            path = metadata[:base_path]

            describe "POST #{path}" do
              let(:params) { |ce| attributes_for(ce.metadata[:resource_name]) }
              let(:instantiation_resource) { accessible_resource }

              before do |current_example|
                if Util.nested_resource? current_example.metadata
                  # we need to fill in the other ids with valid stuff
                  instpath = instantiate_path(path, instantiation_resource)
                  instantiation_resource.destroy!
                else
                  instpath = path
                end

                post instpath, params: params.to_json, headers: request_headers
              end

              instance_eval(&block)

              include_if_needed(:create).auth_examples
              include_if_needed(:create).restricted_examples
            end
          end

          def describe_update(&block)
            path = id_path_template

            describe "PATCH/PUT #{path}" do
              subject { accessible_resource }

              let(:params) { |ce| attributes_for(ce.metadata[:resource_name]) }

              before { patch instantiate_path(path, subject), params: params.to_json, headers: request_headers }

              instance_eval(&block)

              include_if_needed(:update).auth_examples
              include_if_needed(:update).restricted_examples
            end
          end

          def describe_destroy(&block)
            path = id_path_template

            describe "DELETE #{path}" do
              subject { accessible_resource }

              before { delete instantiate_path(path, subject), headers: request_headers }

              instance_eval(&block)

              include_if_needed(:destroy).auth_examples
              include_if_needed(:destroy).restricted_examples
            end
          end

          private

          def include_if_needed(action)
            IncludeIfNeeded.new(self, action)
          end

          def id_path_template
            path = metadata[:base_path]
            metadata[:single_resource] ? path : (path + '/:id')
          end
        end

        def instantiate_path(path, obj)
          path.gsub(/:\w+/) { |s| obj[s[1..-1]] }
        end
      end
    end
  end
end
