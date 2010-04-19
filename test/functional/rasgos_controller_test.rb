require 'test_helper'

class RasgosControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rasgos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rasgo" do
    assert_difference('Rasgo.count') do
      post :create, :rasgo => { }
    end

    assert_redirected_to rasgo_path(assigns(:rasgo))
  end

  test "should show rasgo" do
    get :show, :id => rasgos(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => rasgos(:one).to_param
    assert_response :success
  end

  test "should update rasgo" do
    put :update, :id => rasgos(:one).to_param, :rasgo => { }
    assert_redirected_to rasgo_path(assigns(:rasgo))
  end

  test "should destroy rasgo" do
    assert_difference('Rasgo.count', -1) do
      delete :destroy, :id => rasgos(:one).to_param
    end

    assert_redirected_to rasgos_path
  end
end
