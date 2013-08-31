
get '/' do
  erb :index
end


post '/users' do
  @user_email = params[:user][:email]
  @user = User.find_by_email(@user_email)
  session[:user_id] = @user.id 
  erb :user_home_page
end


get '/users/new' do
  erb :users_new
end


post '/users/new' do
  @user = User.create(params[:user])
  session[:user_id] = @user.id
  erb :user_home_page
end


get '/game/:card_id' do
  # game home renders certain deck of cards
end



get '/game/results' do
  # game results
end











