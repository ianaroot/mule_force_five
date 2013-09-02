helpers do

  def check_log_in
    if session[:user_id].nil?
      @errors = "you are not logged in"
      redirect "/"
    end
  end

  def check_already_logged_in
    if session[:user_id] != nil
      redirect "/game/new"
    end
  end

end
