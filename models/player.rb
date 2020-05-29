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

  def self.all()
    sql = "SELECT * FROM players"
    results = SqlRunner.run(sql)
    return results.map{|player|Pc.new(player)}
  end

  def self.find(id)
    sql = "SELECT * FROM players WHERE id = $1"
    values = [id]
    result = SqlRunner.run(sql,values)
    return Pc.new(result.first)
  end

  def self.delete_all()
    sql = "DELETE FROM players"
    SqlRunner.run(sql)
  end

  def delete()
    sql = "DELETE FROM players WHERE id = $1"
    values = [@id]
    SqlRunner.run(sql,values)

  end

  def update()
    sql = "UPDATE players SET (name, race, class, health, inventory_id)
           = ($1, $2, $3, $4, $5) WHERE id = $6"

    values = [@name,@race,@class,@health,@inventory_id,@id]
    SqlRunner.run(sql,values)
  end
end
