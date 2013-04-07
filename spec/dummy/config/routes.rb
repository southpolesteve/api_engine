Rails.application.routes.draw do

  resources :posts


  mount Api::Engine => "/api"
end
