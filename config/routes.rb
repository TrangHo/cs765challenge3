Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "homes#base_design_1"

  resources :homes, only: [:index] do
    collection do
      get :base_design_1
      get :base_design_2
      get :design_1
      get :design_2
    end
    member do
      get :graph_data
    end
  end
end
