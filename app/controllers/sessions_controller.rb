class SessionsController < ApplicationController
  def new
  end
  
  def login(email, password)
    pswd_digest = Base64.encode64(password)
    User.find_by_sql("SELECT * FROM users WHERE email = '#{email}' AND password_digest = '#{pswd_digest}' LIMIT 1").first
  end
  
  def create
    user = login(params[:email], params[:password])
    
    if user
      session[:user_id] = user.id
      redirect_to home_path, notice: "Logged in!"
    elsif User.find_by_email(params[:email])
      flash.now.alert = "Incorrect password"
      render "new"
    else
      flash.now.alert = "Email not found in system"
      render "new"
    end
  end

  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
end