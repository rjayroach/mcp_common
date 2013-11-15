McpCommon::Engine.routes.draw do
  root to: "home#index"

  get "/config/edit", to: "app_config#edit"
  get "/config", to: "app_config#show"
  post "/config", to: "app_config#update"

  #todo move to McpAuth
#  authenticated :user do
#    root to: "dashboard#index"
#  end

end
