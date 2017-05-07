Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'main#index'

  get '/parser', to: 'main#instagram_parser', as: 'parser'
  get '/followers', to: 'main#pinterest_followers', as: 'followers'

  post '/parser', to: 'main#parse_dirty_links'
end
