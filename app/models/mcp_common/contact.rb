module McpCommon
  class Contact < ActiveRecord::Base
    belongs_to :contactable, polymorphic: true

    #attr_accessible :contact_type_id, :value

    #attr_accessible :contactable_id


    validates :value, :contactable_type, :contactable_id, presence: true

=begin
# This should be in the McpCrm initializer for this record
    scope :mcp_pos_customers, where(:contactable_type => "McpPos::Customer")

    CONTACT_TYPE = {
      'HOME PHONE' => '1',
      'WORK PHONE' => '2',
      'MOBILE PHONE' => '3',
      'HOME EMAIL' => '4',
      'WORK EMAIL' => '5'
    }

    def self.customer_search term
      customers.where("value like ?", "%#{term}%").order(:value)
    end
=end

=begin
# This should be handled by Ransack
    def self.find_with params
      params.empty? ? all : where(params)
    end
=end

  end
end
