DemoApp::Application.routes.draw do
  
  resources :posts


  resources :time_records do 
    member do 
      post 'split_entries' 
      get 'split_entries_div'
    end
  end

  root :to => 'time_records#index'

end
