
get '/' do
  erb :index
end


post '/login' do
  @user_email = params[:user][:email]
  @user = User.find_by_email(@user_email)
  @deck = [Deck.find(1)]
  session[:user_id] = @user.id 
  if @user.login(params[:user][:password]).nil?
    erb :index
  else
    erb :user_home_page
  end
end


get '/users/new' do
  erb :users_new
end


post '/users/new' do
  @deck = [Deck.find(1)]
  @user = User.create(params[:user], 
    password_hash: BCrypt::Password.create(params[:user][:password]))
  session[:user_id] = @user.id

  erb :user_home_page
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
  card_id = session[:card_ids][rand(session[:card_ids].length)]
  
  redirect "/game/card/#{card_id}"
end



















get '/game/card/:card_id' do
  @card = Card.find(params[:card_id])

  erb :game_round_flash_cards
end

post '/game/card/:card_id' do
  #compare input to answer
  @card = Card.find(params[:card_id])
  @guess = Guess.create(card_id: params[:card_id], round_id: session[:round_id], input: params[:input])
  p @guess
  # #create new guess object, with card id, round id, input, and is_correct
  # #set up variable to display actual answer, and whether user was correct
  
  # # p @card
  if @guess.input == Card.find_by_definition(@card.definition).term
    @guess.is_correct = "t"
  end

  solved_cards = Guess.where(round_id: session[:round_id]).where(is_correct: "t")
  # p solved_cards

  solved_cards.each do |guess|
    session[:card_ids] -= [guess.card_id]
  end
  
  new_card = session[:card_ids][rand(session[:card_ids].length)]
  # p new_card


  
  erb :game_round_flash_cards_answer
end














get '/game/results' do
  # game results
end











