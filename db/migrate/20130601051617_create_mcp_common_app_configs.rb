class CreateMcpCommonAppConfigs < ActiveRecord::Migration
  def change
    create_table :mcp_common_app_configs do |t|
      t.string :environment
      t.text :settings

      t.timestamps
    end
  end
end
