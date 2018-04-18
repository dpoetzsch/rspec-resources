# frozen_string_literal: true

require 'rspec/resources/dsl/matchers/json_model_matcher'
require 'rspec/resources/dsl/matchers/error_matcher'

module RSpec
  module Resources
    module DSL
      module Matchers
        extend ActiveSupport::Concern

        def returns_status_code(code)
          expect(response).to have_http_status(code)
        end

        #########################
        ### Return Validators ###
        #########################

        def returns_the_records(*records)
          try_set_description 'returns the requested records'

          expect(base_doc.length).to eq(records.length)

          base_doc.each_with_index do |jd, i|
            expect(Util.access_by_path(jd, attributes_doc_path)).to equal_record(records[i], on: visible_attributes)
          end
        end

        def returns_the_subject
          if subject.is_a? Array
            returns_the_records(*subject)
          else
            try_set_description 'returns the requested record'
            expect(Util.access_by_path(base_doc, attributes_doc_path)).to equal_record(subject, on: visible_attributes)
          end
        end

        def creates_a_new_record(check: nil)
          try_set_description 'creates a new record with the given attributes'

          record = accessible_resource.class.find_by_id(Util.access_by_path(base_doc, id_path))
          expect(record).to be_present
          expect(record).to match_params(check || params)
        end

        def updates_the_subject(check: nil)
          try_set_description 'updates the record with the given attributes'

          expect(subject.reload).to match_params(check || params)
        end

        def destroys_the_subject
          try_set_description 'deletes the record'

          expect(subject.class.find_by_id(subject.id)).to be_nil
        end

        private

        def try_set_description(desc)
          return if RSpec.current_example.metadata[:description].present?
          RSpec.current_example.metadata[:description] = desc
        end

        def json_body
          JSON.parse(response.body)
        end

        def base_doc
          Util.access_by_path(json_body, Util.document_format_hash[:base_path])
        end

        def attributes_doc_path
          Util.document_format_hash[:attributes_path]
        end

        def id_path
          Util.document_format_hash[:id_path]
        end
      end
    end
  end
end
