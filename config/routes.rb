Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :teams do
        get "/members", to: 'teams#team_members'
      end
      resources :members do
        put "/update_team/:team_id", to: 'members#update_team'
      end
      resources :projects do
        get "/members", to: 'projects#project_members'
        post "/members/:member_id", to: 'projects#add_member'
      end
    end
  end
end
