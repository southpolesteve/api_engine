require 'spec_helper'

describe 'Default API' do
  describe '#index' do
    before do
      Post.create(title: "Test")
      get '/api/posts'
    end

    it "uses a plural json root" do
      JSON.parse(response.body).should have_key('posts')
    end

    it "returns all the posts" do
      JSON.parse(response.body).keys.should have(1).item
    end
  end

  describe '#show' do
    before do
      Post.create(title: "Test")
      get '/api/posts/1'
    end

    it "uses a singular json root" do
      JSON.parse(response.body).should have_key('post')
    end

    it "returns the post" do
      JSON.parse(response.body)['post']['title'].should eq('Test')
    end
  end

  describe '#create' do
    context "singular create" do
      before do
        post '/api/posts', post: { title: 'Created post'}
      end

      it "returns a correct response code" do
        response.status.should eq(201)
      end

      it "creates a post" do
        Post.first.title.should eq("Created post")
      end

      it "returns a post with an id" do
        JSON.parse(response.body)['post']['id'].should_not be_nil
      end
    end

    context "bulk create" do
      before do
        post '/api/posts', posts: [{ title: 'First new post' },{ title: 'Second new post' }]
      end

      it "returns a correct response code" do
        response.status.should eq(201)
      end

      it "creates multiple posts" do
        Post.count.should eq(2)
      end
    end
  end

  describe '#update' do

    context "singular update" do
      before do
        Post.create(title: "Test")
        put '/api/posts/1', post: { title: 'Changed' }
      end

      it "returns a correct response code" do
        response.status.should eq(204)
      end

      it "updates a post" do
        Post.find(1).title.should eq("Changed")
      end
    end

    context "bulk update" do
      before do
        Post.create(title: "Test")
        Post.create(title: "Test 2")
        put '/api/posts/bulk', posts: [{ id: 1, title: 'Changed' }, { id: 2, tile: 'Changed 2'}]
      end

      it "returns a correct response code" do
        response.status.should eq(204)
      end

      it "updates the posts" do
        Post.find(1).title.should eq("Changed")
        Post.find(2).title.should eq("Changed 2")
      end
    end
  end

  describe '#destroy' do
    before do
      Post.create(title: "Test")
      delete '/api/posts/1'
    end

    it "returns a correct response code" do
      response.status.should eq(204)
    end
  end
end