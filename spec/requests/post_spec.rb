require 'spec_helper'

describe 'the default api' do

  before do
    Post.create(title:  "Test")
    get '/posts'
  end

  it "uses a json root" do
    JSON.parse(response.body).keys.should include('posts')
  end

  it "returns all the posts" do
    JSON.parse(response.body).keys.should have(1).item
  end

end