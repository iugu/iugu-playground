IuguPlayground::Application.routes.draw do

  constraints(IuguSDK::RootTenancyUrl) do

    
    namespace :api do
      namespace :v1 do
        get 'people' => 'person#index'
        get 'people/s/:query' => 'person#search'
        post 'people' => 'person#create'
        get 'people/:id' => 'person#show'
        put 'people/:id' => 'person#update'
        delete 'people/:id' => 'person#destroy'
        post 'people/:id/undo' => 'person#undo'
      end
    end

    match 'app/(*path)' => 'webapp#entry_point'

    root :to => 'webapp#index'
  end

end
