require 'spec_helper'

describe 'the default api' do

  describe 'index' do
    before do
      Post.create(title: "Test")
      get '/api/posts'
    end

    it "uses a plural json root" do
      JSON.parse(response.body).keys.should include('posts')
    end

    it "returns all the posts" do
      JSON.parse(response.body).keys.should have(1).item
    end
  end

  describe 'show' do
    before do
      Post.create(title: "Test")
      get '/api/posts/1'
    end

    it "uses a singular json root" do
      JSON.parse(response.body).keys.should include('post')
    end

    it "returns the post" do
      JSON.parse(response.body)['post']['title'].should eq('Test')
    end

  end

  describe 'create' do
    before do
      post '/api/posts', post: { title: 'Created post'}
    end

    it "returns the proper status code" do
      response.status.should eq(201)
    end

    it "returns a post with an id" do
      JSON.parse(response.body)['post']['id'].should_not be_nil
    end
  end

  describe 'update' do
    before do
      Post.create(title: "Test")
      put '/api/posts/1', post: { title: 'Changed' }
    end

    it "returns a correct response code" do
      response.status.should eq(204)
    end
  end

  describe 'destroy' do
    before do
      Post.create(title: "Test")
      delete '/api/posts/1'
    end

    it "returns the proper response code" do
      response.status.should eq(204)
    end
  end

end