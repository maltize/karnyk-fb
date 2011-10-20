KarnyKutas::Application.routes.draw do

  match 'karny/nowy' => 'messages#new', :via => :get, :as => :new_message
  match 'karny/nowy' => 'messages#create', :via => :post, :as => :messages
  match 'karny' => 'messages#show', :via => :get, :as => :message

  match 'regulamin' => 'static#rules', :as => :rules
  match 'prywatnosc' => 'static#privacy', :as => :privacy

  root :to => "messages#show"

end
