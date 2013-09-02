
get '/' do
  erb :index
end


post '/' do
  session.clear  
  erb :index
end


post '/login' do
  if @user = User.find_by_email(params[:user][:email])
    session[:user_id] = @user.login(params[:user][:password], params[:user][:email])
    @decks = Deck.all
    redirect '/game/new'
  else
    @errors = "Please enter a correct username and password."
    erb :index
  end
end


get '/users/new' do

  erb :users_new
end

post '/users/new' do
  @decks = Deck.all
  @user = User.create(params[:user], password_hash: params[:user][:password])
  if @user.save
    session[:user_id] = @user.id
    redirect '/game/new'
  else
    @errors = @user.errors.full_messages
    erb :users_new 
  end
end

post '/game/card/new' do 

  params[:card_id] == 'new' 

  deck  = Deck.find_by_name(params[:user][:deck])
  p deck 

  @round = Round.create(:user_id => session[:user_id], :deck_id => deck.id)
  session[:round_id] = @round.id
  cards = Card.where(deck_id: deck.id)
  session[:card_ids] = []
  cards.each { |card| session[:card_ids] << card.id }
  session[:card_ids].shuffle!
  card_id = session[:card_ids][rand(session[:card_ids].length)]

  redirect "/game/card/#{card_id}"
end

get '/game/card/:card_id' do
  @card = Card.find(params[:card_id])

  erb :game_round_flash_cards
end

post '/game/card/:card_id' do
  @card = Card.find(params[:card_id])
  @guess = Guess.create(card_id: params[:card_id], round_id: session[:round_id], input: params[:input])
  @round = Round.find(session[:round_id])

  if @guess.input.downcase == Card.find_by_definition(@card.definition).term.downcase
    @guess.is_correct = true
    session[:card_ids].delete(@card.id)

    @round.times_correct += 1
    @round.save
  else
    @round.times_incorrect += 1
    @round.save
  end

  @new_card_id = session[:card_ids][rand(session[:card_ids].length)]

  if session[:card_ids].count == 0
    @game_over = true 
  else
    @game_over = false
  end


  erb :game_round_flash_cards_answer
end


get '/game/results' do
  @deck = Deck.where(round_id: session[:round_id])
  @guesses = Guess.where(round_id: session[:round_id])
  @times_correct = (Round.find(session[:round_id])).times_correct
  @times_incorrect = (Round.find(session[:round_id])).times_incorrect
  erb :user_game_results
end

get '/game/new' do
  @decks = Deck.all
  @user = User.find(session[:user_id])
  erb :user_home_page
end


# user_home_page.erb needs to render from a different route
# and successful logins and signups need to redirect to that route
# also, the choose another deck button in user_game_results.erb
# need to redirect to that same route
# 
# every page needs to check whether the user has been logged in
# 
# every route needs to check the sessions for whether you're logged in
# and if not, it needs to redirect to the index
# using a partial or a helper







