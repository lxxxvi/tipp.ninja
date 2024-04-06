Rails.application.routes.draw do
  devise_for :users, path: "", path_names: {
    sign_in: "sign_in",
    sign_out: "sign_out",
    password: "secret",
    sign_up: "register"
  }

  get "up" => "rails/health#show", as: :rails_health_check

  resource :dashboard, only: %i[show]
  root "root#index"
end
