require "api_engine/engine"
require "api_engine/config"
require "active_model_serializers"

module ApiEngine

  def self.serializers
    models.map(&:active_model_serializer)
  end

  def self.models
    if config.models
      config.models.map{ |m| m.to_s.classify.constantize }
    else
      Rails.application.eager_load! && ActiveRecord::Base.descendants
    end
  end

end
