Rails.application.routes.draw do
  root to: 'posts#index'

  get 'about' => 'pages#about', as: :about
  get 'contact' => 'pages#contact', as: :contact
  resources :posts
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
