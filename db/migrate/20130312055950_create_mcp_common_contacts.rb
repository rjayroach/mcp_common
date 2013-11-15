class CreateMcpCommonContacts < ActiveRecord::Migration
  def change
    create_table :mcp_common_contacts do |t|
      t.string :value
      t.references :contactable, polymorphic: true
      t.timestamps
    end
  end
end
