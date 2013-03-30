require 'test_helper'

class VisionsControllerTest < ActionController::TestCase
  setup do
    @vision = visions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:visions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create vision" do
    assert_difference('Vision.count') do
      post :create, vision: { dent_company: @vision.dent_company, eff_date: @vision.eff_date, group_name: @vision.group_name, group_number: @vision.group_number, insurance_id: @vision.insurance_id, policy_number: @vision.policy_number }
    end

    assert_redirected_to vision_path(assigns(:vision))
  end

  test "should show vision" do
    get :show, id: @vision
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @vision
    assert_response :success
  end

  test "should update vision" do
    put :update, id: @vision, vision: { dent_company: @vision.dent_company, eff_date: @vision.eff_date, group_name: @vision.group_name, group_number: @vision.group_number, insurance_id: @vision.insurance_id, policy_number: @vision.policy_number }
    assert_redirected_to vision_path(assigns(:vision))
  end

  test "should destroy vision" do
    assert_difference('Vision.count', -1) do
      delete :destroy, id: @vision
    end

    assert_redirected_to visions_path
  end
end
