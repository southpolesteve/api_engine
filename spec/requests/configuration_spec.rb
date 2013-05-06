require 'spec_helper'

describe 'config' do
  before { Post.create(title: "Test") }

  describe 'whitelist' do
    after do
      ApiEngine.configure do |config|
        config.whitelist = false
      end
    end

    context 'Post is not on the whitelist' do
      before do
        ApiEngine.configure do |config|
          config.whitelist = [:comment]
        end
      end

      it "allows access to the model's API" do
        get '/api/posts'
        response.status.should eq(404)
      end
    end

    context 'Post is on the whitelist' do
      before do
        ApiEngine.configure do |config|
          config.whitelist = [:post]
        end
      end

      it "allows access to the model's API" do
        get '/api/posts'
        response.status.should eq(200)
      end
    end
  end

  describe 'current_user_method' do

  end

  describe 'authentication_method' do

  end
end