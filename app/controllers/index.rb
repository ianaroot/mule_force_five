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

  erb :user_home_deck_dashboard
end

post '/' do
  @user_email = params[:user][:email]
  @user = User.find_by_email(@user_email)
  p @user
  # session[:user_id] = @user.id 
  # redirect '/:user_id'
end


post '/new' do
  @user = User.create(params[:user])
  session[:user]
  # redirect '/home'
end

get '/:card_id' do

end











