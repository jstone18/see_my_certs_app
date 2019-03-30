class UsersController < ApplicationController

  get "/users/new" do
    erb :"/users/new.html"
  end

  post "/users" do
    @user = User.new(params)
    if @user.save
      flash[:success] = "Successfully Created Profile! Please log in."
      redirect "/login"
    else
      flash[:error] = "Account creation failure: #{@user.errors.full_messages.to_sentence}"
      redirect "/users/new"
    end
  end

  get '/login' do
    erb :"users/login.html"
  end

  post '/login' do
    set_user
    if @user && @user.authenticate(params[:password])
      session[:id] = @user.id
      flash[:success] = "Successfully logged in!"
      redirect "users/#{@user.username}"
    else
      flash[:error] = "Invalid input! Please create a profile or re-attempt log in with valid input."
      redirect '/login'
    end
  end

  get '/logout' do
    logout!
    redirect "/"
  end

  get "/users/:username" do
    if logged_in?
      set_user
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

  private

  def set_user
    @user = User.find_by(username: params[:username])
  end

end
