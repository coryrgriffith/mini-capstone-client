class Client::ProductsController < ApplicationController
  def index
    input_name = params[:client_search]
    response = Unirest.get("localhost:3000/api/products",
      parameters: {
        input_name: input_name,
        category: params[:category]
      }
    )
    @products = response.body
    render "index.html.erb"
  end

  def show
    product_id = params[:id]
    response = Unirest.get("localhost:3000/api/products/#{product_id}")
    @product = response.body
    render "show.html.erb"
  end

  def new
    @product = {}
    render "new.html.erb"
  end

  def create
    @product = {
                input_name: params[:input_name],
                input_price: params[:input_price],
                input_supplier_id: params[:input_supplier_id],
                input_description: params[:input_description]
                }
    response = Unirest.post("localhost:3000/api/products/", parameters: @product)

    if response.code == 200
      flash[:success] = "You created a new product"
      redirect_to "/client/products"
    else
      @errors = response.body['errors']
      render "new.html.erb"
    end
  end

  def edit
    product_id = params[:id]
    response = Unirest.get("localhost:3000/api/products/#{product_id}")
    @product = response.body
    render "edit.html.erb"
  end

  def update
    @product = {
      "input_name" => params[:input_name],
      "input_price" => params[:input_price],
      "input_supplier_id" => params[:input_supplier_id],
      "input_description" => params[:input_description]
    }
    response = Unirest.patch("localhost:3000/api/products/#{params[:id]}", parameters: @product)

    if response.code == 200
      flash[:success] = "You updated an existing product"
      redirect_to "/client/products/#{@product['id']}"
    else
      @errors = response.body['errors']
      render "edit.html.erb"
    end
  end

  def destroy
    product_id = params[:id]
    response = Unirest.delete("localhost:3000/api/products/#{product_id}")
    flash[:danger] = "You deleted a product"
    redirect_to "/client/products"
  end
end
