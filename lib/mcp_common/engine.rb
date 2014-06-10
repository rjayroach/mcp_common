
# 3rd party libraries
require 'bootstrap-sass'
require 'jquery-datatables-rails'
#require 'rabl'
require 'ransack'
require 'simple_form'
#require 'strong_parameters'
require 'will_paginate'
require 'whenever'
require 'chosen-rails'
require 'geocoder'
require 'draper'

require 'celluloid'
require 'celluloid/autostart'
require 'sucker_punch'

# local libraries


module McpCommon
  class Engine < ::Rails::Engine
    isolate_namespace McpCommon

    initializer :assets do |config|
      Rails.application.config.assets.precompile += %w( mcp_common/geolocate.js )
    end


    # 
    # After rails loads all gems and engines and processes all intializiers
    # this code will add methods to the application's base ApplicationController
    # See: http://stackoverflow.com/questions/3468858/rails-3-0-engine-execute-code-in-actioncontroller
    # Also: http://stackoverflow.com/questions/8797690/rails-3-1-better-way-to-expose-an-engines-helper-within-the-client-app
    # 
=begin
# note: this code is implemented in each of the engine's engine.rb instead of here
    initializer 'mcp_auth.controller' do |app|  
      ActiveSupport.on_load(:action_controller) do  
        Rails.logger.debug { "\nInitializing and include common helpers from #{__FILE__}" } 
        include ActionControllerExtension  
        helper McpCommon::ApplicationHelper
      end
    end
=end


    config.generators do |g|
      g.test_framework :rspec,
        :view_specs => false,
        :helper_specs => false,
        :routing_specs => false,
        :controller_specs => false,
        :request_specs => true,
        :fixtures => true
      g.fixture_replacement :factory_girl, :dir => 'spec/factories/mcp_common'
      g.helper = false
      g.stylesheets = false
    end 

  end
end


