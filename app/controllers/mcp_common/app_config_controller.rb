require_dependency "mcp_common/application_controller"


module McpCommon
  class AppConfigController < ApplicationController

    def show
      @app_config = AppConfig.first.decorate
    end


    def edit
      @app_config = AppConfig.first.decorate
      Rails.logger.debug @app_config.fan_club.settings
    end
  

    def update
      @app_config = AppConfig.first.decorate
      if @app_config.update_attributes(app_config_params)
        redirect_to config_edit_path, notice: 'Application Configuration was successfully updated.'
      else
        render action: :edit
      end
    end


    private

    # strong_parameters
    # todo serialize store values to settings hash
    def app_config_params
      Rails.logger.debug '+' * 30
      r= params[:app_config].permit(settings: [:common_field])
      @app_config.strong_parameters.each do |p|
        r.merge! p.call(params[:app_config])
        #s= params[:app_config].permit(fan_club_attributes: [:id, :facebook_application_id, settings: [:checkin_minimum_interval, :attach_post_id_to_content, :facebook_authentication_source, :impressions, :reach]])
        #r.merge! s
      end
      Rails.logger.debug '+' * 30
      r
    end

  end
end

