class CreateMcpCommonLocations < ActiveRecord::Migration
  def change
    create_table :mcp_common_locations do |t|
      t.string :address1
      t.string :address2
      t.string :address3
      t.string :address4
      t.string :locality
      t.string :region
      t.string :postal_code
      t.string :country
      t.float :latitude
      t.float :longitude
      t.references :locatable, polymorphic: true
      t.timestamps
    end
  end
end
