require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  test "should get register" do
    get events_register_url
    assert_response :success
  end

end
