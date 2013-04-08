module Api
  class ApplicationController < ActionController::Base
    def index
      @posts = model_class.all
      render json: @posts, root: params[:model_name]
    end

    def show
      @post = model_class.find(params[:id])
      render json: @post, root: params[:model_name].singularize
    end

    def create
      @post = model_class.new(params[:post])
      if @post.save
        render json: @post, status: :created
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def update
      @post = model_class.find(params[:id])
      if @post.update_attributes(params[:post])
        head :no_content
      else
        render json: @post.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @post = model_class.find(params[:id])
      @post.destroy
      head :no_content
    end

    private

    def model_class
      params[:model_name].classify.constantize
    end
  end
end
