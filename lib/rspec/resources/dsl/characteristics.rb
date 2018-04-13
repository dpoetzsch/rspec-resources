# frozen_string_literal: true

module RSpec
  module Resources
    module DSL
      module Characteristics
        extend ActiveSupport::Concern

        module ClassMethods
          def visible_attributes(*params)
            params = params.first if params.length == 1 && params.first.is_a?(Array)
            let(:visible_attributes) { params }
          end

          def it_needs_authentication(with_headers: :auth_headers, only: %i[index show create update destroy])
            metadata[:it_needs_authentication] = {
              headers: with_headers,
              error_status: 401,
              only: only,
            }

            metadata[:request_headers] ||= []
            metadata[:request_headers].push with_headers
          end

          def it_has_restricted_access(for_resource: :restricted_resource, only: %i[index show create update destroy])
            metadata[:it_has_restricted_access] = {
              for_resource: for_resource,
              error_status: 404,
              only: only,
            }
          end
        end
      end
    end
  end
end
