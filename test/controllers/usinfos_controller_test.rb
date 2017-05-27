require 'test_helper'

class UsinfosControllerTest < ActionController::TestCase
  setup do
    @usinfo = usinfos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usinfos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usinfo" do
    assert_difference('Usinfo.count') do
      post :create, usinfo: { birthday: @usinfo.birthday, user_id: @usinfo.user_id, username: @usinfo.username }
    end

    assert_redirected_to usinfo_path(assigns(:usinfo))
  end

  test "should show usinfo" do
    get :show, id: @usinfo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @usinfo
    assert_response :success
  end

  test "should update usinfo" do
    patch :update, id: @usinfo, usinfo: { birthday: @usinfo.birthday, user_id: @usinfo.user_id, username: @usinfo.username }
    assert_redirected_to usinfo_path(assigns(:usinfo))
  end

  test "should destroy usinfo" do
    assert_difference('Usinfo.count', -1) do
      delete :destroy, id: @usinfo
    end

    assert_redirected_to usinfos_path
  end
end
