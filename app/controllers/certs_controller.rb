class CertsController < ApplicationController

  get '/certs' do
    if logged_in?
      @certs = current_user.certs
      erb :"certs/index.html"
    else
      # flash login message
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
      #flash success message
      redirect "/certs/#{@cert.id}"
    else
      # flash error
      redirect "/certs/new"
    end
  end

  # GET: /certs/5
  get "/certs/:id" do
    set_cert
    if logged_in?
      erb :"/certs/show.html"
    else
      # flash login message
      redirect "/login"
    end
  end

  # GET: /certs/5/edit
  get "/certs/:id/edit" do
    set_cert
    if logged_in?
      if authorized?(@cert)
        erb :"/certs/edit.html"
      else
        #flash message
        redirect "/users/#{current_user.username}"
      end
    else
      # flash message
      redirect "/login"
    end
  end

  # PATCH: /certs/5
  patch "/certs/:id" do
    set_cert
    if logged_in?
      if authorized?(@cert)
        @cert.update(cert_name: params[:cert_name], cert_number: params[:cert_number], exp_date: params[:exp_date])
        # flash message
        redirect "/certs/#{@cert.id}"
      else
        #flash message
        redirect "/users/#{current_user.username}"
      end
    else
      # flash message
      redirect "/"
    end
  end

  # DELETE: /certs/5/delete
  delete "/certs/:id/delete" do
    set_cert
    @cert.destroy
    # flash message
    redirect "/certs"
  end

  private

  def set_cert
    @cert = Cert.find(params[:id])
  end
end
