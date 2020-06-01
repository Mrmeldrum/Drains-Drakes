require_relative('../models/inventory')
require_relative('../models/player')
require('pry')

Pc.delete_all
Inventory.delete_all

inv1 = Inventory.new({"potions" => "Mana Potion, Health Potion", "weapon" => "daggers", "armour" => "chainmail"})
inv1.save()

player1 = Pc.new({"name" => "Gronc", "race" => "Gnome", "class" => "Warrior", "health" => 200, "inventory_id" => inv1.id})
player1.save()

player2 = Pc.new({"name" => "Gronc", "race" => "Gnome", "class" => "Warrior", "health" => 200, "inventory_id" => inv1.id})
player2.save()

binding.pry
nil
