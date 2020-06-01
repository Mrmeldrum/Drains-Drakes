require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/player')
require_relative('../models/inventory')
also_reload('../models/*')

get '/players' do
  @players = Pc.all()
  erb( :"players/index")
end

get '/players/new' do
  erb( :"players/new")
end

post '/players' do
  @inventory = Inventory.new(params)
  @inventory.save
  params[:inventory_id] = @inventory.id
  @player = Pc.new(params)
  @player.save
  redirect to("/players")
end

post '/players/:id/delete' do
  player = Pc.find(params[:id])
  player.delete()
  redirect to("/players")
end

post '/players/new_party' do
  Pc.delete_all()
  redirect to("/players")
end

get '/players/:id/edit' do
  @player = Pc.find(params[:id])
  erb(:"players/edit")
end

post '/players/:id' do
  @player = Pc.find(params[:id])
  @player.health = params[:health]
  @player.update()

  @inventory = Inventory.find(@player.inventory_id)
  @inventory.weapon = params[:weapon]
  @inventory.armour = params[:armour]
  @inventory.potions = params[:potions]
  @inventory.update()
  redirect to("/players")
end
