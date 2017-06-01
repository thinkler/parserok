Rails.application.routes.draw do
  devise_for :users

  root 'main#index'

  get '/parser', to: 'main#instagram_parser', as: 'parser'
  get '/followers', to: 'main#pinterest_followers', as: 'followers'
  get '/titleizer', to: 'main#titleizer', as: 'titleizer'
  get '/page_generator', to: 'main#page_generator', as: 'page_generator'

  post '/parser', to: 'main#parse_dirty_links', as: 'pictures'
  post '/followers', to: 'main#parse_followers', as: 'pinterest'
  post '/titleizer', to: 'main#capitalize_titles', as: 'titles'
  post '/page_generator', to: 'main#generate_page', as: 'generate_page'

  post '/update_bastards', to: 'main#update_bastards'
  post '/del_bastards', to: 'main#delete_bastards', as: 'unfollow'
end
