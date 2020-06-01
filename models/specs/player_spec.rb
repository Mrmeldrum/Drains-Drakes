require('minitest/autorun')
require('minitest/reporters')
Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative('../player')
require_relative('../inventory')

class PlayerTest < MiniTest::Test

  def setup()
    @player = Pc.new(options)
    @inventory = Inventory.new("Red", "Daggers", "Chainmail")
  end

  def test_can_get_inv
    assert_equal("Daggers", @player.inventory)

  end

end
