# frozen_string_literal: true

module RSpec
  module Resources
    module Util
      def self.nested_resource?(metadata)
        metadata[:base_path] =~ /:\w+/
      end
    end
  end
end
