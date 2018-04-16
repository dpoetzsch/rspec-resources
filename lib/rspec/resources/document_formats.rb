# frozen_string_literal: true

module RSpec
  module Resources
    DOCUMENT_FORMATS = {
      # Resource end points with most simple data format
      # Example response:
      # {
      #   "id": "5",
      #   "text": "Loren ipsum"
      # }
      simple: {
        # path to the content of the response
        base_path: '',
        # path to the resource id relative to base path
        id_path: 'id',
        # path to the attributes section of the resource relative to base path
        attributes_path: '',
        # path to error objects; may either be an array or a single object
        error_path: '',
        # the path to the error message relative to an error object (see error_path)
        error_detail_path: 'message',
      }.freeze,

      # Resource end points with simple data format wrapped in a data field
      # Example response:
      # {
      #   "data": {
      #     "id": "5",
      #     "text": "Loren ipsum"
      #   }
      # }
      simple_wrapped: {
        # path to the content of the response
        base_path: 'data',
        # path to the resource id relative to base path
        id_path: 'id',
        # path to the attributes section of the resource relative to base path
        attributes_path: '',
        # path to error objects; may either be an array or a single object
        error_path: 'errors',
        # the path to the error message relative to an error object (see error_path)
        error_detail_path: 'message',
      }.freeze,

      # Resource end points conforming to json api specification (http://jsonapi.org/)
      # Example response:
      # {
      #   "data": {
      #     "id": "5",
      #     "type": "article",
      #     "attributes": {
      #       "text": "Loren ipsum"
      #     }
      #   }
      # }
      jsonapi: {
        # path to the content of the response
        base_path: 'data',
        # path to the resource id relative to base path
        id_path: 'id',
        # path to the attributes section of the resource relative to base path
        attributes_path: 'attributes',
        # path to error objects; may either be an array or a single object
        error_path: 'errors',
        # the path to the error message relative to an error object (see error_path)
        error_detail_path: 'detail',
      }.freeze,
    }.freeze
  end
end
