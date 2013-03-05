DemoApp::Application.routes.draw do

  resources :time_records do 
    collection do 
      get 'split_entries' 
      get 'split_entries_div'
    end
  end

  root :to => 'time_records#index'

end
