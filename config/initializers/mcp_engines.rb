
APPLICATION_ENGINES = []

Rails.application.railties.engines.collect do |engine|
  engine_name = engine.class.to_s.split('::')[0]
  if eval(engine_name).respond_to? :mcp 
    APPLICATION_ENGINES << {railtie: engine, name: engine_name.underscore}
  end
end
Rails.logger.debug "Mapped mcp engines: #{APPLICATION_ENGINES.map {|e| e[:name]}} from #{__FILE__}"


config_file = "#{Rails.root}/config/application.yml"
if File.exists? config_file

  # Load Application Settings - common across applications
  APPLICATION_CONFIG = YAML.load_file(config_file)[Rails.env]


  # Set the relative url if app is deployed to a subdirectory
  # See: https://github.com/rails/rails/issues/6933
  if APPLICATION_CONFIG['relative_url']
    Rails.application.routes.default_url_options[:script_name] = "/#{APPLICATION_CONFIG['relative_url']}"
  end

  # If the 'asset_dir' config variable is set then ensure the directory tree exists and set a couple of system variables
  if APPLICATION_CONFIG['asset_dir']
    APPLICATION_CONFIG['view_path'] = "/#{APPLICATION_CONFIG['asset_dir']}"
    APPLICATION_CONFIG['asset_path'] = "#{Rails.root}/public/#{APPLICATION_CONFIG['asset_dir']}"
    if not File.directory? "#{APPLICATION_CONFIG['asset_path']}/"
      FileUtils.mkdir_p "#{APPLICATION_CONFIG['asset_path']}/"
    end
  end


  # Override ActionMailer settings if they exist in the config file
  if APPLICATION_CONFIG['smtp_settings']
    ActionMailer::Base.delivery_method = :smtp
    ActionMailer::Base.smtp_settings = Hash[APPLICATION_CONFIG['smtp_settings'].map{ |k, v| [k.to_sym, v] }]
  end

else

  APPLICATION_CONFIG = []
end

