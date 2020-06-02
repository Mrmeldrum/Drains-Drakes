require('sinatra')
require('sinatra/contrib/all')
require_relative('../models/player')
require_relative('../models/inventory')
also_reload('../models/*')
require('pry')

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

post '/players/edit_all' do
  player_names = params.keys()
  for player_name in player_names
    player_details = params[player_name]
    @player = Pc.find(player_details[:id])
    @player.health = player_details[:health]
    @player.update()

    @inventory = Inventory.find(@player.inventory_id)
    @inventory.weapon = player_details[:weapon]
    @inventory.armour = player_details[:armour]
    @inventory.potions = player_details[:potions]
    @inventory.update()
  end
  redirect to("/players")
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

get '/players/edit' do
  @players = Pc.all()
  erb(:"players/edit_all")
end
