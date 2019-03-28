class CertsController < ApplicationController

  # GET: /certs/new
  get "/certs/new" do
    erb :"/certs/new.html"
  end

  # POST: /certs
  post "/certs" do
    redirect "/certs"
  end

  # GET: /certs/5
  get "/certs/:id" do
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
    redirect "/certs"
  end
end
