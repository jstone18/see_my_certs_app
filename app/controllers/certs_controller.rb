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
    @certs = Cert.find(params[:id])
    erb :"/certs/show.html"
  end

  # GET: /certs/5/edit
  get "/certs/:id/edit" do
    erb :"/certs/edit.html"
  end

  # PATCH: /certs/5
  patch "/certs/:id" do
    redirect "/certs/:id"
  end

  # DELETE: /certs/5/delete
  delete "/certs/:id/delete" do
    @cert = Cert.find(params[:id])
    binding.pry
    @cert.destroy
    redirect "/certs"
  end
end
