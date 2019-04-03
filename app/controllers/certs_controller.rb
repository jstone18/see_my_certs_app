class CertsController < ApplicationController

  get '/certs' do
    redirect_if_not_logged_in
    @certs = current_user.certs
    erb :"certs/index.html"
  end

  get "/certs/new" do
    redirect_if_not_logged_in
    erb :"/certs/new.html"
  end

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

  get "/certs/:id" do
    redirect_if_not_logged_in
    set_cert
    erb :"/certs/show.html"
  end

  get "/certs/:id/edit" do
    set_cert
    redirect_if_not_logged_in
    if authorized?(@cert)
      erb :"/certs/edit.html"
    else
      flash[:error] = "You can only edit credentials present in your Certification Record. Please try again."
      redirect "/users/#{current_user.username}"
    end
  end

  patch "/certs/:id" do
    set_cert
    redirect_if_not_logged_in
    if authorized?(@cert) && params[:cert_name] != "" && params[:exp_date] != ""
      @cert.update(cert_name: params[:cert_name], cert_number: params[:cert_number], exp_date: params[:exp_date])
      flash[:success] = "You've Successfully Created a Certification!"
      redirect "/certs/#{@cert.id}"
    else
      flash[:error] = "Something went wrong! Please try again and be sure to fill in all required fields."
      redirect "/certs"
    end
  end

  delete "/certs/:id/delete" do
    redirect_if_not_logged_in
    set_cert
    @cert.destroy
    flash[:success] = "Your certification was successfully deleted from your record!"
    redirect "/certs"
  end

  private

  def set_cert
    @cert = Cert.find(params[:id])
  end
end
