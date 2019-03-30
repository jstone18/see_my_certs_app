class CertsController < ApplicationController

  get '/certs' do
    if logged_in?
      @certs = Cert.all
      erb :"certs/index.html"
    else
      redirect "/login"
    end
  end

  # GET: /certs/new
  get "/certs/new" do
    erb :"/certs/new.html"
  end

  # POST: /certs
  post "/certs" do
    if !logged_in?
      redirect "/login"
    end
    if params[:cert_name] && params[:exp_date] != ""
      @cert = Cert.create(cert_name: params[:cert_name], cert_number: params[:cert_number], exp_date: params[:exp_date], user_id: current_user.id)
      redirect "/certs/#{@cert.id}"
    else
      # flash error
      redirect "/certs/new"
    end
  end

  # GET: /certs/5
  get "/certs/:id" do
    set_cert
    erb :"/certs/show.html"
  end

  # GET: /certs/5/edit
  get "/certs/:id/edit" do
    set_cert
    if logged_in?
      if @cert.user == current_user
        erb :"/certs/edit.html"
      else
        redirect "/users/#{current_user.username}"
      end
    else
      redirect "/"
    end
  end

  # PATCH: /certs/5
  patch "/certs/:id" do
    set_cert
    if logged_in?
      if @cert.user == current_user
        @cert.update(cert_name: params[:cert_name], cert_number: params[:cert_number], exp_date: params[:exp_date])
        redirect "/certs/#{@cert.id}"
      else
        redirect "/users/#{current_user.username}"
      end
    else
      redirect "/"
    end
  end

  # DELETE: /certs/5/delete
  delete "/certs/:id/delete" do
    set_cert
    @cert.destroy
    redirect "/certs"
  end

  private

  def set_cert
    @cert = Cert.find(params[:id])
  end
end
