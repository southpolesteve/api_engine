require 'spec_helper'

describe 'schema' do
  before do
    get '/api/schema'
  end

  it "returns a JSON response" do
    JSON.parse(response.body).should have_key('resources')
  end

  it "includes the API models" do
    JSON.parse(response.body)['resources'].keys.should =~ ['comments', 'posts']
  end

end