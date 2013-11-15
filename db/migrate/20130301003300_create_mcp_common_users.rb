class CreateMcpCommonUsers < ActiveRecord::Migration
  def change
    create_table :mcp_common_users do |t|
      t.references :mcp_auth_user
      t.string :locale
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    add_index :mcp_common_users, :mcp_auth_user_id
  end
end
