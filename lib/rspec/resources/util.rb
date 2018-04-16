# frozen_string_literal: true

module RSpec
  module Resources
    module Util
      def self.nested_resource?(metadata)
        metadata[:base_path] =~ /:\w+/
      end

      def self.access_by_path(doc, path)
        path.split('.').each { |p| doc = doc[p] } if path.present?
        doc
      end

      def self.document_format_hash(metadata = nil)
        doc_format = (metadata || RSpec.current_example.metadata)[:document_format]

        return DOCUMENT_FORMATS[doc_format] if doc_format.is_a?(Symbol) || doc_format.is_a?(String)
        doc_format.respond_to?(:with_indifferent_access) ? doc_format.with_indifferent_access : doc_format
      end
    end
  end
end
