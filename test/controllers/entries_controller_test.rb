require 'test_helper'

class EntriesControllerTest < ActionController::TestCase
    include Devise::TestHelpers
  def setup
    @direction = directions(:one)
    @entry = entries(:one)
    @entrytwo = entries(:two)
    @entrythree = entries(:three)
    @user = users(:one)
    @usertwo = users(:two)
    @directions = Direction.where(scenario_id: @entry.direction.scenario_id)
    @current_direction = @directions.find_index(@entry.direction)
    @next_direction = @directions[@current_direction + 1]
  end

  test "should get index" do
    sign_in @user
    get :index
    assert_response :success
    assert_not_nil assigns(:entries)
  end

  test "should create entry" do
    sign_in @usertwo
    assert_difference('Entry.count') do
      post :create, entry: { title: @entrytwo.title, body: @entrytwo.body, direction_id: @entrytwo.direction_id, user_id: @entrytwo.user_id }
    end

    assert_redirected_to editor_new_path(direction_id:@next_direction)
  end

  test "should leave scenario if finished last entry" do
    sign_in @user
    assert_difference('Entry.count') do
      post :create, entry: { title: @entrythree.title, body: @entrythree.body, direction_id: @entrythree.direction_id, user_id: @entrythree.user_id }
    end

    assert_redirected_to root_path
  end

  test "should update entry" do
    sign_in @usertwo
    patch :update, id: @entrytwo, entry: { title: @entrytwo.title, body: @entrytwo.body, direction_id: @entrytwo.direction_id, user_id: @entrytwo.user_id }

    assert_redirected_to editor_new_path(direction_id:@next_direction)
  end

  test "should load update instead of new if next entry is complete" do
    sign_in @user
    patch :update, id: @entry, entry: { title: @entry.title, body: @entry.body, direction_id: @entry.direction_id, user_id: @entry.user_id }

    assert_redirected_to editor_edit_path(direction_id:@next_direction, id: @entrythree)
  end

  test "should destroy entry" do
    sign_in @user
    assert_difference('Entry.count', -1) do
      delete :destroy, id: @entry
    end

    assert_redirected_to root_path
  end

end
