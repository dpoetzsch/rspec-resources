# frozen_string_literal: true

module RSpec
  module Resources
    module DSL
      module Matchers
        extend ActiveSupport::Concern

        def returns_the_records(*records)
          try_set_description 'returns the requested records'

          expect(json).to have_key('data')
          expect(json_data.length).to eq(records.length)

          json_data.each_with_index do |jd, i|
            expect(jd['attributes']).to equal_record(records[i], on: visible_attributes)
          end
        end

        def returns_the_subject
          if subject.is_a? Array
            returns_the_records(*subject)
          else
            try_set_description 'returns the requested record'
            expect(json).to have_key('data')
            expect(json_data['attributes']).to equal_record(subject, on: visible_attributes)
          end
        end

        def creates_a_new_record
          try_set_description 'creates a new record with the given attributes'

          record = accessible_resource.class.find_by_id(json_data['id'])
          expect(record).to be_present
          expect(record).to match_params
        end

        def updates_the_subject
          try_set_description 'updates the record with the given attributes'

          expect(subject.reload).to match_params
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
      end
    end
  end
end
