class SessionsController < ApplicationController
  def new
  end

  def create
    username = params[:username]
    password = params[:password]
    authenticated = false
    user_role = nil

    File.foreach(Rails.root.join('Password.txt')) do |line|
      user, pass, role = line.chomp.split(';')
      if user == username && pass == password
        authenticated = true
        user_role = role
        break
      end
    end

    if authenticated
      session[:user_id] = username # Example of storing username in session
      flash[:notice] = "Login successful! Welcome, #{username}."
      redirect_to root_path # Replace with the appropriate page
    else
      flash[:error] = "Invalid username or password."
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You have logged out."
    redirect_to login_path
  end
end
