require 'test_helper'

class InstitucionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:institucions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create institucion" do
    assert_difference('Institucion.count') do
      post :create, :institucion => { }
    end

    assert_redirected_to institucion_path(assigns(:institucion))
  end

  test "should show institucion" do
    get :show, :id => institucions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => institucions(:one).to_param
    assert_response :success
  end

  test "should update institucion" do
    put :update, :id => institucions(:one).to_param, :institucion => { }
    assert_redirected_to institucion_path(assigns(:institucion))
  end

  test "should destroy institucion" do
    assert_difference('Institucion.count', -1) do
      delete :destroy, :id => institucions(:one).to_param
    end

    assert_redirected_to institucions_path
  end
end
