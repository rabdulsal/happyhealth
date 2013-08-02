require 'test_helper'

class BlueButtonControllerTest < ActionController::TestCase
  test "should get receive_attachment" do
    get :receive_attachment
    assert_response :success
  end

end
