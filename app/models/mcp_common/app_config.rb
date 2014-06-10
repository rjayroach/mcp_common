
=begin
AppConfig model vs Applicaiton.yml
AppConfig values are:
- editable by user
- don't require app restart on change

Application.yml values are:
- editable by developer
- require app restart

=end

module McpCommon
  class AppConfig < ActiveRecord::Base
    #attr_accessible :environment, :settings

    validates :environment, presence: true, uniqueness: true

    #
    # The model will only return a record with an environment that matches the current Rails env:
    # See: http://stackoverflow.com/questions/1834159/overriding-a-rails-default-scope
    # use model.unscoped
    #
    default_scope { where(environment: Rails.env) }

    before_validation :set_environment

    before_destroy :prohibit_destroy


    # 
    # The environment is always set to the current Rails environment
    #
    def set_environment; self.environment = Rails.env; end


    #
    # The record cannot be destroyed
    #
    def prohibit_destroy; false; end


    store :settings, accessors: [ :common_field ]

  end
end

