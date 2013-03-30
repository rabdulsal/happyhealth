require 'test_helper'

class DentalsControllerTest < ActionController::TestCase
  setup do
    @dental = dentals(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dentals)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dental" do
    assert_difference('Dental.count') do
      post :create, dental: { dent_company: @dental.dent_company, eff_date: @dental.eff_date, group_name: @dental.group_name, group_number: @dental.group_number, insurance_id: @dental.insurance_id, policy_number: @dental.policy_number }
    end

    assert_redirected_to dental_path(assigns(:dental))
  end

  test "should show dental" do
    get :show, id: @dental
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dental
    assert_response :success
  end

  test "should update dental" do
    put :update, id: @dental, dental: { dent_company: @dental.dent_company, eff_date: @dental.eff_date, group_name: @dental.group_name, group_number: @dental.group_number, insurance_id: @dental.insurance_id, policy_number: @dental.policy_number }
    assert_redirected_to dental_path(assigns(:dental))
  end

  test "should destroy dental" do
    assert_difference('Dental.count', -1) do
      delete :destroy, id: @dental
    end

    assert_redirected_to dentals_path
  end
end
