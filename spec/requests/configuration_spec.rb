require 'spec_helper'

describe 'Configuration Spec' do
  describe 'config.models' do

    before { Post.create(title: "Test") }

    after do
      ApiEngine.configure do |config|
        config.models = false
      end
    end

    context 'Post is not on the models' do

      before do
        ApiEngine.configure do |config|
          config.models = [:comment]
        end
      end

      it "allows access to the model's API" do
        get '/api/posts'
        response.status.should eq(404)
      end
    end

    context 'Post is on the models' do

      before do
        ApiEngine.configure do |config|
          config.models = [:post]
        end
      end

      it "allows access to the model's API" do
        get '/api/posts'
        response.status.should eq(200)
      end
    end
  end
end