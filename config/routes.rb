Rails.application.routes.draw do
  get "/" => "login#homepage"
  post "/login/twitter" => "login#login_twitter"
  get "/auth/twitter/callback" =>"login#account"

  get "/dashboard" => "dashboard#dashboard"

  get "/posts" => "dashboard#add_posts"
  get "/fetch_posts" => "dashboard#show_posts"
  get "/tweet/seller" => "dashboard#send_tweet"
end
