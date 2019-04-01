class UsersController < ApplicationController

  get '/users' do
    redirect_if_not_logged_in
    redirect "/users/#{current_user.username}"
  end

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

  get "/users/:username" do
    set_user
    redirect_if_not_logged_in
    erb :"/users/show.html"
  end

  # GET: /users/5/edit
  get "/users/:username/edit" do
    set_user
    redirect_if_not_logged_in
    if current_user
      erb :"/users/edit.html"
    else
      redirect "/users/#{current_user.username}"
    end
  end

  # PATCH: /users/5
  patch "/users/:username" do
    set_user
    redirect_if_not_logged_in
    if @user
      binding.pry
      @user.update(full_name: params[:full_name], provider_level: params[:provider_level], email: params[:email])
      flash[:success] = "Successfully edited profile."
      redirect "/users/#{@user.username}"
    else
      flash[:error] = "Something went wrong! Please try again, be sure there are no blank fields."
      redirect "/users"
    end
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
