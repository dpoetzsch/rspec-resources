# frozen_string_literal: true

module RSpec
  module Resources
    module DSL
      module Matchers
        class JsonModelMatcher
          def initialize(expectation, attributes)
            @expectation = expectation.is_a?(Hash) ? expectation.with_indifferent_access : expectation
            @attributes = attributes
          end

          def matches?(subject)
            @subject = subject

            @fails = []

            @attributes.map(&:to_s).each do |a|
              exp = @expectation[a]
              subj = @subject[a]

              @fails.push(attribute: a, expectation: exp, subject: subj) if exp != subj
            end

            @fails.empty?
          end

          def failure_message
            if @subject.is_a? Hash
              # we most likely check the result of a get operation
              "Expected returned attributes to match:\n#{formatted_fails}"
            else
              # we most likely check an update or create here
              "Expected model attributes to match:\n#{formatted_fails}"
            end
          end

          def failure_message_when_negated
            "Expected to not match:\n#{formatted_fails}"
          end

          private

          def formatted_fails
            @fails.map do |f|
              "  #{f[:attribute]} was '#{f[:subject]}' but expected to be '#{f[:expectation]}'"
            end.join("\n")
          end
        end

        def equal_record(record, hash)
          JsonModelMatcher.new(record, hash[:on])
        end

        def match_params(iparams = nil)
          iparams ||= params
          JsonModelMatcher.new(iparams, iparams.keys)
        end
      end
    end
  end
end
