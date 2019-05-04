# frozen_string_literal: true

Rails.application.routes.draw do
  root to: 'blog/pages#top'

  devise_for :authors
  as :author do
    get 'authors/edit' => 'authors/registrations#edit', as: :edit_user_registration
    put 'author/:id' => 'authors/registrations#update', as: :user_registration
  end

  namespace :authors do
    resources :posts do
      member do
        put 'publish' => 'posts#publish'
        put 'unpublish' => 'posts#unpublish'
      end
    end
    resources :tags, only: %i[index create destroy]
    post '/tinymce_assets' => 'tinymce_assets#create'
  end

  scope module: 'blog' do
    get 'top' => 'pages#top', as: :top
    get 'posts' => 'posts#index', as: :posts
    get 'posts/:id' => 'posts#show', as: :post
  end
end
