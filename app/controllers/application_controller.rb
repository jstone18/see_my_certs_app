class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "ems2019"
    register Sinatra::Flash
  end

  get "/" do
    erb :index
  end

  helpers do

    def set_user
      @user = User.find_by(username: params[:username])
    end

    def current_user
      @current_user ||= User.find_by(id: session[:id])
    end

    def logged_in?
      !!current_user
    end

    def logout!
      session.clear
    end

    def authorized?(cert)
      cert.user == current_user
    end

    def redirect_if_not_logged_in
      if !logged_in?
        flash[:error] = "You must be logged in to perform this action. Please sign up or log in."
        redirect '/'
      end
    end

  end
end
