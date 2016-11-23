require 'test_helper'

class StaticControllerTest < ActionController::TestCase
    include Devise::TestHelpers
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

end
