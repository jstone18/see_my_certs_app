class SessionsController < ApplicationController

  get '/login' do
    erb :"users/login.html"
  end

  post '/login' do
    set_user
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      flash[:success] = "Successfully logged in!"
      redirect "users/#{@user.username}"
    elsif
      @user && !@user.authenticate(params[:password])
      flash[:error] = "Invalid Password. Please try again"
      redirect "/login"
    else
      flash[:error] = "Invalid username. Please try again or create a profile if none exists"
      redirect '/login'
    end
  end

  get '/logout' do
    logout!
    redirect "/"
  end

end
