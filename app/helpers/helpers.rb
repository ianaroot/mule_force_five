helpers do

  def check_log_in
    if session[:user_id].nil?
      @errors = "you are not logged in"
      redirect "/"
    end
  end

  def login_successful
    user_id = User.login(params[:user])
    session[:user_id] = user_id
  end

  def check_already_logged_in
    if session[:user_id] != nil
      redirect "/game/new"
    end
  end

  def set_sessions_and_redirect_if_signup_successful
    if @user.save
      session[:user_id] = @user.id
      redirect '/game/new'
    else
      false
    end
  end

  def store_card_ids_in_sessions(deck)
    cards = Card.where(deck_id: deck.id)
    session[:card_ids] = []
    cards.each { |card| session[:card_ids] << card.id }
    session[:card_ids].shuffle!
  end

  def choose_next_card
    session[:card_ids][rand(session[:card_ids].length)]
  end

  def increment_times_correct_or_incorrect
    if @guess.input.downcase == Card.find_by_definition(@card.definition).term.downcase
      @guess.is_correct = true
      @round.times_correct += 1
      @round.save
    else
      @round.times_incorrect += 1
      @round.save
    end
  end

  def remove_card_from_deck_if_correct
    if @guess.input.downcase == Card.find_by_definition(@card.definition).term.downcase
      session[:card_ids].delete(@card.id)
    end
  end

  def game_over?
    session[:card_ids].count == 0
  end

  def make_round_hash(deck)
    {:user_id => session[:user_id], :deck_id => deck.id}
  end

  def make_guess_hash(params)
    {card_id: params[:card_id], round_id: session[:round_id], input: params[:input]}
  end

end
