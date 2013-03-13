require 'test_helper'

class InsuranceQueriesControllerTest < ActionController::TestCase
  setup do
    @insurance_query = insurance_queries(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:insurance_queries)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create insurance_query" do
    assert_difference('InsuranceQuery.count') do
      post :create, insurance_query: { new: @insurance_query.new, show: @insurance_query.show }
    end

    assert_redirected_to insurance_query_path(assigns(:insurance_query))
  end

  test "should show insurance_query" do
    get :show, id: @insurance_query
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @insurance_query
    assert_response :success
  end

  test "should update insurance_query" do
    put :update, id: @insurance_query, insurance_query: { new: @insurance_query.new, show: @insurance_query.show }
    assert_redirected_to insurance_query_path(assigns(:insurance_query))
  end

  test "should destroy insurance_query" do
    assert_difference('InsuranceQuery.count', -1) do
      delete :destroy, id: @insurance_query
    end

    assert_redirected_to insurance_queries_path
  end
end
