class EditorController < ApplicationController
  before_action :authenticate_user!
  before_action :find_entry, only:[:edit]
  before_action :find_direction, only:[:new, :edit]

  def new
    @entry = Entry.new
    @entry.direction_id = params[:direction_id]
    @entry.user_id = current_user.id
    @directions = Direction.where(scenario_id: @entry.direction.scenario_id)
  end

  def edit
    @directions = Direction.where(scenario_id: @entry.direction.scenario_id)
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :body, :direction_id, :user_id)
  end

  def find_entry
    @entry = Entry.find(params[:id])
  end

  def find_direction
    @direction = Direction.find_by_id(params[:direction_id])
  end
end
