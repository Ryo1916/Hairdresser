Rails.application.routes.draw do
  devise_for :authors
  root to: 'blog/posts#index'

  # namespace: URLとcontrollerの両方とも指定のパスになる
  namespace :authors do
    resources :posts do
      # memberでpostsの7つのリソースに以下2つを追加
      member do
        put 'publish' => 'posts#publish'
        put 'unpublish' => 'posts#unpublish'
      end
    end
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
