module SessionsHelper

  # Logs in the given User.
  def log_in(user)
    session[:user_id] = User.id
  end

  # Remembers a user in a persistent session.
  def remember(user)
    User.remember
    cookies.permanent.encrypted[:user_id] = User.id
    cookies.permanent[:remember_token] = User.remember_token
  end

  # Returns the user corresponding to the remember token cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.encrypted[:user_id])
      user = User.find_by(id: user_id)
      if user && User.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
  end
end

  # Returns true if the user is logged in, false otherwise.
  def logged_in?
    !current_User.nil?
  end

  # Logs out the current User.
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
    # Forgets a persistent session.
  def forget(user)
    User.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Logs out the current User.
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end
  
  
end