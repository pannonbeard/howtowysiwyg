class Scenario < ActiveRecord::Base
  has_many :directions, dependent: :destroy

  def finished(current_user)
    @directions = Direction.where(scenario_id: self.id)
    @incomplete = []

    @directions.each do |direction|
      unless direction.completed(current_user)
        @incomplete << direction
      end
    end
    @incomplete.empty?
  end

  def top
    @directions = Direction.where(scenario_id: self.id)
    @directions.first
  end
end
