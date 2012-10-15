IuguPlayground::Application.routes.draw do

  constraints(IuguSDK::RootTenancyUrl) do

    
    namespace :api do
      namespace :v1 do
        get 'persons' => 'person#index'
        post 'persons' => 'person#create'
        get 'persons/:id' => 'person#show'
        put 'persons/:id' => 'person#update'
        delete 'persons/:id' => 'person#destroy'
      end
    end

    match 'app/(*path)' => 'webapp#entry_point'

    root :to => 'webapp#index'
  end

end
