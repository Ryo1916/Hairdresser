Rails.application.routes.draw do
  root to: 'blog/posts#index'

  # namespace: URLとcontrollerの両方とも指定のパスになる
  namespace :author do
    resources :posts
  end

  # scope module: controllerのみ指定のパスになる
  scope module: 'blog' do
    get 'about' => 'pages#about', as: :about
    get 'contact' => 'pages#contact', as: :contact
    get 'posts' => 'posts#index', as: :posts
    get 'posts/:id' => 'posts#show', as: :post
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
