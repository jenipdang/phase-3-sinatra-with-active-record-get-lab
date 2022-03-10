class ApplicationController < Sinatra::Base

  set :default_content_type, 'application/json'

  # add routes
  get '/bakeries' do
    # get all the bakeries from the database
    bakeries = Bakery.all
    # send them back as a JSON array
    bakeries.to_json
  end

  get '/bakeries/:id' do
    # look up the bakery in the database using its ID
    bakeries = Bakery.find(params[:id])
    # send them back as a JSON array
    bakeries.to_json(only: [:id, :name], include: { baked_goods: {only: [:name, :price]}})
  end

  get '/baked_goods/by_price' do
    # get all the baked goods sort by desc order
    # baked_goods = BakedGood.all.order(:price).reverse_order
    baked_goods = BakedGood.all.reorder('price DESC')
    # send a JSON-formatted response of the baked goods data with selective attributes
    baked_goods.to_json(only: [:id, :name, :price])
  end

  get '/baked_goods/most_expensive' do
    # look up the baked goods in the database using price
    most_expensive = BakedGood.all.max_by(&:price)
    # send them back as a JSON array
    most_expensive.to_json(only: [:id, :name, :price])
  end

end
