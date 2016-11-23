class StaticController < ApplicationController
  def index
    @scenarios = Scenario.all
  end

  def contact
    @directions = Direction.all
  end
end
