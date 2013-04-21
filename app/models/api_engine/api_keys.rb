module ApiEngine
  class ApiKeys < ActiveRecord::Base
    attr_accessible :access_token
  end
end
