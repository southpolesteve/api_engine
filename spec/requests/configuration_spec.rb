require 'spec_helper'

describe 'Configuration Spec' do
  describe 'config.whitelist' do

    before { Post.create(title: "Test") }

    after(:all) do
      ApiEngine.configure do |config|
        config.whitelist = false
      end
    end

    context 'Post is on the whitelist' do

      before do
        ApiEngine.configure do |config|
          config.whitelist = []
        end
      end

      it "does not allow access to the model's API" do
        get '/api/posts'
        JSON.parse(response.body).should have_key('posts')
      end
    end

    context 'Post is not on the whitelist' do

      before do
        ApiEngine.configure do |config|
          config.whitelist = [:post]
        end
      end

      it "allows access to the model's API" do
        get '/api/posts'
        JSON.parse(response.body).keys.should have(1).item
      end
    end
  end
end