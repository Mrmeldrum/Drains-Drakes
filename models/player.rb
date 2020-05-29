require_relative( '../db/sql_runner' )

# Pc = Player Character

class Pc

  attr_reader :id
  attr_accessor :name, :race, :class, :health, :inventory_id

  def initialize(options)
    @id = options['id'].to_i if options['id']
    @name = options['name']
    @race = options['race']
    @class = options['class']
    @health = options['health']
    @inventory_id = options['inventory_id'].to_i

  end

  def save()
    sql = "INSERT INTO players
           (name, race, class, health, inventory_id) VALUES
           ($1, $2, $3, $4, $5) RETURNING id"

    values = [@name,@race,@class,@health,@inventory_id]
    @id = SqlRunner.run(sql,values)[0]['id'].to_i
  end

end
