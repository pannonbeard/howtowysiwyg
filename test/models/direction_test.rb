require 'test_helper'

class DirectionTest < ActiveSupport::TestCase
  def setup
    @direction = directions(:one)
    @user = users(:one)
  end

   test "should find the directions entries" do
     assert_equal @direction.user_entry(@user).id, 1
   end

   test "should check for completion" do
     assert @direction.completed(@user)     
   end
end
