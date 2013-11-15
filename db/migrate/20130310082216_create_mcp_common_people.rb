class CreateMcpCommonPeople < ActiveRecord::Migration
  def change
    create_table :mcp_common_people do |t|
      t.string :first_name
      t.string :last_name
      t.references :personable, polymorphic: true 

      t.timestamps
    end
  end
end
