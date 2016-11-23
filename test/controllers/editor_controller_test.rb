require 'test_helper'

class EditorControllerTest < ActionController::TestCase
    include Devise::TestHelpers
  def setup
    @direction = directions(:one)
    @entry = entries(:one)
    @user = users(:one)
    sign_in @user
  end

  test "should get new" do
    get :new, direction_id: @direction
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @entry, direction_id: @direction, scenario_id: @entry.direction.scenario_id
    assert_response :success
  end

end
