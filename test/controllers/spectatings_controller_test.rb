require 'test_helper'

class SpectatingsControllerTest < ActionController::TestCase
  setup do
    @spectating = spectatings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spectatings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spectating" do
    assert_difference('Spectating.count') do
      post :create, spectating: { address: @spectating.address, content: @spectating.content, date: @spectating.date, description: @spectating.description, latitude: @spectating.latitude, longitude: @spectating.longitude, title: @spectating.title }
    end

    assert_redirected_to spectating_path(assigns(:spectating))
  end

  test "should show spectating" do
    get :show, id: @spectating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @spectating
    assert_response :success
  end

  test "should update spectating" do
    patch :update, id: @spectating, spectating: { address: @spectating.address, content: @spectating.content, date: @spectating.date, description: @spectating.description, latitude: @spectating.latitude, longitude: @spectating.longitude, title: @spectating.title }
    assert_redirected_to spectating_path(assigns(:spectating))
  end

  test "should destroy spectating" do
    assert_difference('Spectating.count', -1) do
      delete :destroy, id: @spectating
    end

    assert_redirected_to spectatings_path
  end
end
