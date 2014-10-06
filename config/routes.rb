AchievementUnlocked::Application.routes.draw do
  resources :users do
    resources :goals, only: [:new, :create]
  end
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:new, :create]
  resources :comments, only: [:create]

end
