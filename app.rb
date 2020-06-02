require('sinatra')
require('sinatra/contrib/all')
require_relative('controllers/inventory_controller')
require_relative('controllers/player_controller')
also_reload('./models/*')


get '/' do
  erb(:index)
end
