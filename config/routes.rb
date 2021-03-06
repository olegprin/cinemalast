Rails.application.routes.draw do

  
  

  resources :comments

  resources :searches
  resources :infos
  put "voices/:increase_id" => "voices#increase", :as => "voices_increase"
  put "voices/:decrease_id" => "voices#decrease", :as => "voices_decrease"

  namespace :admin do
    resources  :admins
    resources  :configurables
    resources  :clients
    resources  :tasks
  end
  
  get 'admins/index'
    
  resources :searches do 
    collection do
      post "search_film" => "searches#search_film"
    end
  end



  
  get 'home/index'

  get 'store/index'
  get 'store/all_category'
  get 'store/show'
  get 'store/contact'
  get 'line/increase',to: 'line_items#increase', as: :increase_line_item
  get 'line/decrease',to: 'line_items#decrease', as: :decrease_line_item
  get 'store/showlike'
  get '/change_locale/:locale', to: 'pages#change_locale', as: :change_locale
  



  
 
 
  

  #devise_for :admins do
    #collection do
    #end
  #end
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get '/users/:id/finish_signup' => 'users#finish_signup', via: [:get, :patch], :as => :finish_signup

  #devise_for :users, :controllers => { :omniauth_callbacks => "omniauth_callbacks" }

  get "browse/:folder_id" => "loads#browse", :as => "browse"
  get "browse/:folder_id/new_folder" => "folders#new", :as => "new_sub_folder"
  delete 'user_delete/:id' => 'admins#delete_user', as: "delete_user"
  get "info_show_from_email/:user_id" => "infos#show_from_email", :as => "user_show"
  get "info_show_from_navbar/:user_id" => "infos#show_from_navbar", :as => "user_show_navbar"
  get "ban_the_user/:id" => "admins#ban_the_user", :as => "ban"
  
resources :infos 




 resources :films do
 
    resources :comments, module: :films do
      collection do
        get "new_with_info" => "comments#new_with_info"
      end
    end  
    collection do
      get "search" => "films#search"
      get "trailer" => "films#trailer"
      get "latest" => "films#latest"
      get "top_rated" => "films#top_rated"
      get "action" => "films#action"
      get "documental" => "films#documental"
      get "films/search" => "films#search", :as => "search_film"
      get "comedy" => "films#comedy", :as => "comedy"
      get "history" => "films#history", :as => "history"
      get "horror" => "films#horror", :as => "horror"
      get "other" => "films#other"
    end
    member do
      get "show_modal" => "films#show_modal"
      put "like"=>"films#upvote"
      put "dislike"=>"films#downvote"
     
    end
  end
   get "films/get/:id" => "films#get", :as => "download_film"




  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#all_film'

end
