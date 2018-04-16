# frozen_string_literal: true

module RSpec
  module Resources
    module DSL
      module Actions
        class IncludeIfNeeded
          def initialize(context, action)
            @ctx = context
            @action = action
          end

          attr_reader :action

          def auth_examples
            with_meta_for :it_needs_authentication do |incl_meta|
              context 'when authentication is missing' do
                let(incl_meta[:headers]) { {} }

                it "denies access with status code #{incl_meta[:error_status]}" do
                  expect(response).to have_http_status(incl_meta[:error_status])
                end
              end
            end
          end

          def restricted_examples
            with_meta_for :it_has_restricted_access do |incl_meta|
              case action
              when :index then restricted_index_examples incl_meta
              when :create then restricted_create_examples incl_meta
              else
                context 'when trying to access a restricted resource' do
                  subject { send incl_meta[:for_resource] }

                  it "denies access with status code #{incl_meta[:error_status]}" do
                    expect(response).to have_http_status(incl_meta[:error_status])
                  end
                end
              end
            end
          end

          private

          def restricted_index_examples(incl_meta)
            context 'when only restricted resources are in database' do
              subject { [send(incl_meta[:for_resource])] }

              if Util.nested_resource? metadata
                # we can not access the parent resource
                # thus we get a not found error
                it { returns_status_code 404 }
              else
                it 'returns no records' do
                  expect(base_doc).to be_empty
                end

                it { returns_status_code 200 }
              end
            end
          end

          def restricted_create_examples(incl_meta)
            return unless Util.nested_resource? metadata

            context 'when using a restricted parent resource' do
              let(:instantiation_resource) { send incl_meta[:for_resource] }

              it { returns_status_code 404 }
            end
          end

          def context(*args, &block)
            @ctx.context(*args, &block)
          end

          def metadata
            @ctx.metadata
          end

          def with_meta_for(key)
            incl_meta = metadata[key]
            return if incl_meta.nil? || !incl_meta[:only].include?(action)

            yield incl_meta
          end
        end
      end
    end
  end
end
