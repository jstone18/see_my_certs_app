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

  get "/users/:username" do
    set_user
    redirect_if_not_logged_in
    erb :"/users/show.html"
  end

  get "/users/:username/edit" do
    set_user
    redirect_if_not_logged_in
    if current_user
      erb :"/users/edit.html"
    else
      redirect "/users/#{current_user.username}"
    end
  end

  patch "/users/:username" do
    set_user
    redirect_if_not_logged_in
    if @user && params[:full_name] != "" && params[:email] != "" && params[:username] != ""
      binding.pry
      @user.update(full_name: params[:full_name], provider_level: params[:provider_level], current_agency: params[:current_agency], email: params[:email])
      flash[:success] = "Successfully edited profile."
      redirect "/users/#{@user.username}"
    else
      flash[:error] = "Something went wrong! Please try again, be sure there are no blank fields."
      redirect "/users"
    end
  end

  delete "/users/:id" do
    redirect_if_not_logged_in
    set_user
    @user.destroy
    flash[:success] = "Your certification was successfully deleted from your record!"
    redirect "/"
  end

end
