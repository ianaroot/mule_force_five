get '/' do
  check_already_logged_in
  erb :index
end

post '/' do
  session.clear  
  erb :index
end

post '/login' do
  check_already_logged_in
  if verify_login_set_session_and_redirect_to_game_new
  else
    @errors = "Please enter a correct username and password."
    erb :index
  end
end

get '/users/new' do
  check_already_logged_in
  erb :users_new
end

post '/users/new' do
  check_already_logged_in
  @user = User.create(params[:user])
  if set_sessions_and_redirect_if_signup_successful
  else
    @errors = @user.errors.full_messages
    erb :users_new 
  end
end

post '/game/card/new' do
  check_log_in
  deck  = Deck.find_by_name(params[:user][:deck])
  round_hash = make_round_hash(deck)
  @round = Round.create(round_hash)
  store_card_ids_in_sessions(deck)
  session[:round_id] = @round.id
  card_id = choose_next_card
  redirect "/game/card/#{card_id}"
end

get '/game/card/:card_id' do
  check_log_in
  @card = Card.find(params[:card_id])
  erb :game_round_flash_cards
end

post '/game/card/:card_id' do
  check_log_in
  @card = Card.find(params[:card_id])
  guess_hash = make_guess_hash(params)
  @guess = Guess.create(guess_hash)
  @round = Round.find(session[:round_id])
  increment_times_correct_or_incorrect
  remove_card_from_deck_if_correct
  @new_card_id = choose_next_card
  @game_over = game_over?
  erb :game_round_flash_cards_answer
end


get '/game/results' do
  check_log_in
  @times_correct = (Round.find(session[:round_id])).times_correct
  @times_incorrect = (Round.find(session[:round_id])).times_incorrect
  erb :user_game_results
end

get '/game/new' do
  check_log_in
  @decks = Deck.all
  @user = User.find(session[:user_id])
  erb :user_home_page
end



