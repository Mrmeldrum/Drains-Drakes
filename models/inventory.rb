require_relative( '../db/sql_runner' )

class Inventory

  attr_reader :id
  attr_accessor :potions, :weapon, :armour

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @potions = options['potions']
    @weapon = options['weapon']
    @armour = options['armour']

  end

  def save()
    sql = "INSERT INTO inventory (potions, weapon, armour) VALUES
           ($1, $2, $3) RETURNING id"
    values = [@potions, @weapon, @armour]
    @id = SqlRunner.run(sql, values)[0]['id'].to_i
  end

  def self.all()
    sql = "SELECT * FROM inventory"
    results = SqlRunner.run(sql)
    return results.map{|inventory| Inventory.new(inventory)}
  end

  def self.find(id)
    sql = "SELECT * FROM inventory WHERE id = $1"
    values = [id]
    results = SqlRunner.run(sql, values)
    return Inventory.new(results.first)
  end

  def self.delete_all()
    sql = "DELETE FROM inventory"
    SqlRunner.run(sql)
  end

  def update()
    sql = "UPDATE inventory SET (potions, weapon, armour)
           = ($1, $2 ,$3) WHERE id = $4"

    values = [@potions,@weapon,@armour,@id]
    SqlRunner.run(sql,values)
  end
end
