# frozen_string_literal: true
Swapsea2::Application.routes.draw do

  resources :event_logs

  resources :activities

  resources :notices do
    collection do
      get :admin
    end
  end

  resources :notice_acknowledgements

  post 'sms', to: 'sms#index'
  post 'api/v1/import/members', to: 'api#upload_members'
  post 'api/v1/import/awards', to: 'api#upload_awards'
  post 'api/v1/import/patrol-members', to: 'api#upload_patrol_members'
  #post 'api/v1/import/rosters', to: 'api#import_rosters'
  get 'api/v1/transfer/members', to: 'api#transfer_members'
  get 'api/v1/transfer/awards', to: 'api#transfer_awards'
  get 'api/v1/transfer/patrol-members', to: 'api#transfer_patrol_members'
  #get 'api/v1/transfer', to: 'api#transfer'

  get 'ics/:key', to: 'users#ics', as: 'ics'

  resources :clubs do
    collection do
    get :admin
  end
  end

  resources :emails do
    collection do
      post 'send_weekly_patrol_rosters'
      post 'send_weekly_skills_maintenance'
      post 'send_welcome_email_test'
      post 'send_welcome_email'
      get :admin
    end
  end

  resources :outreach_patrol_sign_ups

  resources :outreach_patrols do
    collection do
      get 'admin'
    end
  end

  get 'skills-maintenance', to: 'proficiencies#index'

  resources :settings

  resources :proficiency_signups

  resources :proficiencies do
    collection do
      get 'admin'
    end
  end

  get 'switch-user', to: 'selected_user#index', as: 'switch_user'
  post 'selected_user', to: 'selected_user#set'

  get 'token', to: 'home#token'
  get 'auth', to: 'home#token'

  %w( 400 402 403 404 405 406 408 422 500 502 503 504 505 ).each do |code|
    get code, to: 'errors#show', code: code
  end

  get 'admin', to: 'admin#index', as: 'admin'

  resources :swaps do
    collection do
      get 'confirmed'
      get 'my-requests'
      get 'my-offers'
    end
  end


  resources :offers do
    member do
      get 'accept'
      get 'decline'
      get 'confirm-accept', to: 'offers#confirm_accept', as: 'confirm_accept'
      get 'confirm-decline', to: 'offers#confirm_decline', as: 'confirm_decline'
      get 'confirm-cancel', to: 'offers#confirm_cancel', as: 'confirm_cancel'
    end
  end

  resources :requests do
    member do
      get 'confirm-cancel', to: 'requests#confirm_cancel', as: 'confirm_cancel'
    end
  end

  get 'swaps', to: 'rosters#swaps'
  get 'swaps/:view', to: 'rosters#swaps'

  resources :patrol_members do
    collection do
      post :import
      get :admin
    end
  end

  resources :patrols do
    collection do
      get :admin
    end
  end

  resources :awards do
    collection do
      post :import
      get :admin
    end
  end

  resources :rosters do
    collection do
      post :import
      get :member
      get :admin
    end
    member do
      get 'patrol'
      get 'report', defaults: { format: 'pdf' }
    end
  end

  get 'patrol-report/:token', to: 'rosters#patrol_report', as: 'patrol_report', defaults: { format: 'pdf' }

  devise_scope :user do
    get 'login', to: 'users/sessions#new', as: 'login'
  end

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    confirmations: 'users/confirmations',
    unlocks: 'users/unlocks'
  }

  get 'dashboard', to: 'dashboard#index', as: 'dashboard'
  get 'activate', to: 'users#activate'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'
  get 'thanks', to: 'home#thanks'
  get 'privacy-policy', to: 'home#privacy_policy', as: 'privacy_policy'
  get 'terms-of-use', to: 'home#terms_of_use', as: 'terms_of_use'
  get 'about', to: 'home#about_us', as: 'about_us'

  resources :users do
    collection do
      post :import
      get :admin
    end
  end

  resources :leads do
    collection do
      get :admin
    end
  end



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
