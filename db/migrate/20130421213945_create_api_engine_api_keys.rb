class CreateApiEngineApiKeys < ActiveRecord::Migration
  def change
    create_table :api_engine_api_keys do |t|
      t.string :access_token

      t.timestamps
    end
  end
end
