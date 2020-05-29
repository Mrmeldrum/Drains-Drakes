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

end
