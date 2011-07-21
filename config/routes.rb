Tracker::Application.routes.draw do

  #Devise
  devise_for :user, 
             :path_names => { :sign_in => "login", :sign_out => "logout" }

  resources :categories, :expenses, :users

  root :to => "expenses#index"

end
