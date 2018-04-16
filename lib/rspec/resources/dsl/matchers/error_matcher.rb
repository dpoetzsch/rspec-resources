# frozen_string_literal: true

module RSpec
  module Resources
    module DSL
      module Matchers
        class ErrorMatcher
          def initialize(code, msg)
            @code = code
            @msg = msg
          end

          def matches?(subject)
            @subject = subject

            error_docs = Util.access_by_path(JSON.parse(@subject.body), Util.document_format_hash[:error_path])
            error_docs = [error_docs] unless error_docs.is_a?(Array)

            @subject.code == @code.to_s && error_docs.any? { |d| match_doc(d) }
          end

          def match_doc(error_doc)
            @msg.nil? || Util.access_by_path(error_doc, Util.document_format_hash[:error_detail_path]).match(@msg)
          end

          def failure_message
            "Expected to get an error but got code #{@subject.code} and body #{@subject.body}"
          end

          def failure_message_when_negated
            "Expected to get no error but got code #{@subject.code} and body #{@subject.body}"
          end

          def description
            "return an error with code #{@code}"
          end

          private

          def obj_name
            @obj.class.name.downcase
          end
        end

        def return_an_error(hash)
          code = hash[:with_code]
          msg = hash[:with_message] || hash[:and_message]

          ErrorMatcher.new(code, msg)
        end

        def returns_an_error(hash)
          expect(response).to return_an_error(hash)
        end
      end
    end
  end
end
