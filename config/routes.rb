AchievementUnlocked::Application.routes.draw do
  resources :users do
    resources :comments, only: [:create]
    resources :goals, only: [:new, :create]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:new, :create] do
      resources :comments, only: [:create]
    end

end
