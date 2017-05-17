Rails.application.routes.draw do
  devise_for :users

  root 'main#index'

  get '/parser', to: 'main#instagram_parser', as: 'parser'
  get '/followers', to: 'main#pinterest_followers', as: 'followers'
  get '/titleizer', to: 'main#titleizer', as: 'titleizer'

  post '/parser', to: 'main#parse_dirty_links', as: 'pictures'
  post '/followers', to: 'main#parse_followers', as: 'pinterest'
  post '/titleizer', to: 'main#capitalize_titles', as: 'titles'

  post '/update_bastards', to: 'main#update_bastards'
  post '/del_bastards', to: 'main#delete_bastards', as: 'unfollow'
end
