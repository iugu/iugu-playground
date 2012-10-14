IuguPlayground::Application.routes.draw do

  constraints(IuguSDK::RootTenancyUrl) do

    match 'a(/*path)' => 'entry_point#index'

    namespace :api do
      namespace :v1 do
        get 'persons' => 'person#index'
        post 'persons' => 'person#create'
        get 'persons/:id' => 'person#show'
        put 'persons/:id' => 'person#update'
        delete 'persons/:id' => 'person#destroy'
      end
    end

  end

end
