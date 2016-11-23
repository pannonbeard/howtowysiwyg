require 'test_helper'

class ScenarioTest < ActiveSupport::TestCase
  def setup
    @scenario = scenarios(:one)
    @user = users(:one)
    @directions = Direction.where(scenario_id: @scenario.id)
  end

  test "should tell if a scenario has been completed" do
    assert @scenario.finished(@user), "It was not empty!"
  end

  test "should get the first direction in the scenario" do
    assert_equal @scenario.top, @directions.first
  end
end
