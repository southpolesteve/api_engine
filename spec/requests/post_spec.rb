require 'spec_helper'

describe 'the default api' do

  it "shows all posts" do
    post = Post.create(title: "Test")
    get '/posts'
    JSON.parse(response.body).keys.should include('posts')
  end
end