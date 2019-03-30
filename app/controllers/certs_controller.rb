class CertsController < ApplicationController

  get '/certs' do
    if logged_in?
      @certs = current_user.certs
      erb :"certs/index.html"
    else
      flash[:error] = "Please log in to view certifications!"
      redirect "/login"
    end
  end

  # GET: /certs/new
  get "/certs/new" do
    if logged_in?
      erb :"/certs/new.html"
    else
      flash[:error] = "Please log in or sign up to create a new certification."
      redirect "/login"
    end
  end

  # POST: /certs
  post "/certs" do
    if !logged_in?
      redirect "/login"
    end
    if params[:cert_name] && params[:exp_date] != ""
      @cert = Cert.create(cert_name: params[:cert_name], cert_number: params[:cert_number], exp_date: params[:exp_date], user_id: current_user.id)
      flash[:success] = "You've Successfully created a new certification!"
      redirect "/certs/#{@cert.id}"
    else
      flash[:error] = "Something went wrong! Please try submitting form again. Make sure all required fields are complete."
      redirect "/certs/new"
    end
  end

  # GET: /certs/5
  get "/certs/:id" do
    set_cert
    if logged_in?
      erb :"/certs/show.html"
    else
      flash[:error] = "Please log in or sign up to view a certification."
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
        flash[:error] = "You can only edit credentials present in your Certification Record. Please try again."
        redirect "/users/#{current_user.username}"
      end
    else
      flash[:error] = "You must be logged in to edit credentials. Please sign up or log in."
      redirect "/login"
    end
  end

  # PATCH: /certs/5
  patch "/certs/:id" do
    set_cert
    if logged_in?
      if authorized?(@cert) && params[:cert_name] != "" && params[:exp_date] != ""
        @cert.update(cert_name: params[:cert_name], cert_number: params[:cert_number], exp_date: params[:exp_date])
        flash[:success] = "You've Successfully Created a Certification!"
        redirect "/certs/#{@cert.id}"
      else
        flash[:error] = "Something went wrong! Please try again and be sure to fill in all required fields."
        redirect "/certs"
      end
    else
      flash[:error] = "You are not logged in! Please log in or create a profile."
      redirect "/"
    end
  end

  # DELETE: /certs/5/delete
  delete "/certs/:id/delete" do
    if logged_in?
      set_cert
      @cert.destroy
      flash[:success] = "Your certification was successfully deleted from your record!"
      redirect "/certs"
    else
      redirect "/"
    end
  end

  private

  def set_cert
    @cert = Cert.find(params[:id])
  end
end
