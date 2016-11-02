require 'test_helper'

class GroupsControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get groups_url
    assert_response :success
  end

end
