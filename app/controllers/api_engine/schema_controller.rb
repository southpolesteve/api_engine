module ApiEngine
  class SchemaController < ActionController::Base

    def index
      render json: schema
    end

    private

    def schema
      resp = { resources: {} }
      ApiEngine.models.each do |model|
        model_key = model.to_s.downcase.pluralize.to_sym
        model_schema = {}
        model_schema[model_key] = model.active_model_serializer.schema
        resp[:resources][model_key] = model_schema
      end
      resp
    end

  end
end
