# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'blog/pages#top'

  devise_for :authors
  # author.rbにregisterable未設定のため、registrationへのルーティング追記
  as :author do
    get 'authors/edit' => 'authors/registrations#edit', as: :edit_user_registration
    put 'author/:id' => 'authors/registrations#update', as: :user_registration
  end

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
    get 'top' => 'pages#top', as: :top
    get 'posts' => 'posts#index', as: :posts
    get 'posts/:id' => 'posts#show', as: :post
  end
end
