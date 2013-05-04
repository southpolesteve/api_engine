require 'spec_helper'

describe 'Default API' do
  let(:post1) { Post.create(title: "Test") }
  let(:post2) { Post.create(title: "Test 2") }

  describe '#index' do
    let(:post2) { Post.create(title: "Test 2") }
    let(:post3) { Post.create(title: "Test 3") }

    context "no ids are passed" do
      before do
        post1 && post2
        get '/api/posts'
      end

      it "uses a plural json root" do
        JSON.parse(response.body).should have_key('posts')
      end

      it "returns all the posts" do
        JSON.parse(response.body)['posts'].should have(2).items
      end
    end

    context "ids are passed in a parameter" do
      before do
        post1 && post2 && post3
        get "/api/posts?ids=[#{post1.id},#{post3.id}]"
      end

      it "uses a plural json root" do
        JSON.parse(response.body).should have_key('posts')
      end

      it "returns only the posts with supplied ids" do
        JSON.parse(response.body)['posts'].map{ |p| p['id'] }.should =~ [post1.id, post3.id]
      end
    end
  end

  describe '#show' do
    before do
      post1
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
    before do
      post1
      put '/api/posts/1', post: { title: 'Changed' }
    end

    it "returns a correct response code" do
      response.status.should eq(200)
    end

    it "returns the saved post" do
      JSON.parse(response.body)['post'].should eq({'id' => 1, 'title' => 'Changed'})
    end

    it "updates a post" do
      Post.find(1).title.should eq("Changed")
    end
  end

  describe "#bulk_update" do
    before do
      post1 && post2
      put '/api/posts/bulk', posts: [{ id: 1, title: 'Changed' }, { id: 2, title: 'Changed 2'}]
    end

    it "returns a correct response code" do
      response.status.should eq(200)
    end

    it "returns the saved posts" do
      JSON.parse(response.body)['posts'].should =~ [{ 'id' => 1, 'title' => 'Changed' }, { 'id' => 2, 'title' => 'Changed 2'}]
    end

    it "updates the posts" do
      Post.find(1).title.should eq("Changed")
      Post.find(2).title.should eq("Changed 2")
    end
  end

  describe '#destroy' do
    before do
      post1
      delete '/api/posts/1'
    end

    it "returns a correct response code" do
      response.status.should eq(204)
    end

    it "deletes the record" do
      Post.count.should eq(0)
    end
  end

  describe '#bulk_destroy' do
    before do
      post1 && post2
      delete '/api/posts/bulk', posts: [{ id: 1, title: 'Test' }, { id: 2, title: 'Test 2'}]
    end

    it "returns a correct response code" do
      response.status.should eq(204)
    end

    it "deletes the sent records" do
      Post.count.should eq(0)
    end
  end
end