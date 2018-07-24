class Client::CartedProductsController < ApplicationController
  def index
    response = Unirest.get("localhost:3000/api/carted_products")
    @carted_products = response.body
    render "index.html.erb"
  end

  def new
    @message = "You Carted a Product!"
    render "new.html.erb"
  end

  def show
    carted_product_id = params[:id]
    response = Unirest.get("localhost:3000/api/carted_products/#{carted_product_id}")
    @carted_product = response.body
    render "show.html.erb"
  end

  def create
    response = Unirest.post("localhost:3000/api/carted_products", parameters:
      {
        product_id: params[:product_id],
        quantity: params[:quantity]
      }
    )
    carted_product = response.body
    redirect_to "/client/carted_products"
    flash[:success] = "You added an item to your cart."
  end

  def destroy
    carted_product_id = params[:id]
    response = Unirest.patch("localhost:3000/api/carted_products/#{carted_product_id}")
    flash[:destroy] = "You removed an item from your cart."
    redirect_to "/client/carted_products"
  end
end
