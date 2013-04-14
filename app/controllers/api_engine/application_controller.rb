module ApiEngine
  class ApplicationController < ActionController::Base
    def index
      @models = model_class.all
      render json: @models, root: plural_model
    end

    def show
      @model = model_class.find(params[:id])
      render json: @model, root: singular_model
    end

    def create
      if bulk_operation?
        @models = []
        params[plural_model].each do |attributes|
          @models << model_class.create!(attributes)
        end
        render json: @models, status: :created
      else
        @model = model_class.new(params[singular_model])
        if @model.save
          render json: @model, status: :created
        else
          render json: @model.errors, status: :unprocessable_entity
        end
      end
    end

    def update
      @model = model_class.find(params[:id])
      if @model.update_attributes(params[singular_model])
        render json: @model
      else
        render json: @model.errors, status: :unprocessable_entity
      end
    end

    def bulk_update
      @models = []
      params[plural_model].each do |attributes|
        id = attributes.delete('id')
        object = model_class.find(id)
        object.update_attributes!(attributes)
        @models << object
      end
      render json: @models, root: plural_model
    end

    def destroy
      @model = model_class.find(params[:id])
      @model.destroy
      head :no_content
    end

    def bulk_destroy
      @models = model_class.find(params[plural_model].map{ |m| m['id']})
      @models.map(&:destroy)
      head :no_content
    end

    private

    def model_class
      params[:model_name].classify.constantize
    end

    def plural_model
      params[:model_name]
    end

    def singular_model
      params[:model_name].singularize
    end

    def bulk_operation?
      params[plural_model] ? true : false
    end

  end
end
