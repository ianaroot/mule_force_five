# home page
get '/' do
  # Look in app/views/index.erb
  erb :index
end

# create new user
get '/new' do

  erb :create_new_user
end

get '/:user_id' do

  erb :user_home_page
end

post '/' do

  redirect '/:user_id'
end


post '/new' do
  erb :user_home_page
end











