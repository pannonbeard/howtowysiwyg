class EntriesController < ApplicationController
  authorize_resource
  before_action :authenticate_user!
  before_action :find_entry, only: [:edit, :update, :show, :destroy]
  def index
    @entries = Entry.all
  end

  def show
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      get_directions(@entry)
      scenario_redirect
    else
      redirect_to editor_new_path(direction_id: @entry.direction_id)
    end
  end

  def update
    get_directions(@entry)
    if @entry.update(entry_params)
      scenario_redirect
    else
      flash[:alert] = "What did you forget?!"
      redirect_to editor_edit_path( id:current_direction(@entry).user_entry(current_user).id,
        direction_id:current_direction(@entry))
    end
  end

  def destroy
    @entry.destroy
    redirect_to root_path
  end

  private
  def entry_params
    params.require(:entry).permit(:title, :body, :direction_id, :user_id)
  end


  def find_entry
    @entry = Entry.find(params[:id])
  end

## regrabbing the current set up directions on the editor page
  def get_directions(entry)
    @directions = Direction.where(scenario_id: entry.direction.scenario_id)
  end

  def current_direction(entry)
    @current_direction_index = @directions.find_index(entry.direction)
    @current_direction = @directions[@current_direction_index]
  end

  def next_direction(entry)
    @current_direction_index = @directions.find_index(entry.direction)
    @next_direction = @directions[@current_direction_index + 1]
  end

## redirecting to the next set of directions
  def scenario_redirect
    begin
      if next_direction(@entry).completed(current_user)
        redirect_to editor_edit_path( id:next_direction(@entry).user_entry(current_user).id,
          direction_id:next_direction(@entry))
      else
        redirect_to editor_new_path(direction_id: next_direction(@entry))
      end
    rescue NoMethodError
      flash[:notice] = "Finished!"
      redirect_to root_path
    end
  end
end
