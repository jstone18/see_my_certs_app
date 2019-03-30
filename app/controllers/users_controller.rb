class UsersController < ApplicationController

  get "/users/new" do
    erb :"/users/new.html"
  end

  post "/users" do
    if params[:full_name] != "" && params[:email] != "" && params[:password] != "" && params[:username] != ""
      @user = User.create(params)
      redirect "/login"
    else
      # flash "Not a Valid Input or Missing Info"
      redirect "/users/new"
    end
  end

  get '/login' do
    erb :"users/login.html"
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      # flash "Successfully Logged In!."
      redirect "users/#{@user.username}"
    else
      redirect '/login'
    end
  end

  get '/logout' do
    logout!
    redirect "/"
  end

  get "/users/:username" do
    if logged_in?
      @user = User.find_by(username: params[:username])
    else
      redirect "/login"
    end
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:id/edit" do
    erb :"/users/edit.html"
  end

  # PATCH: /users/5
  patch "/users/:id" do
    redirect "/users/:id"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    redirect "/users"
  end
end
