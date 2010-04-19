require 'test_helper'

class EvaluacionsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:evaluacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create evaluacion" do
    assert_difference('Evaluacion.count') do
      post :create, :evaluacion => { }
    end

    assert_redirected_to evaluacion_path(assigns(:evaluacion))
  end

  test "should show evaluacion" do
    get :show, :id => evaluacions(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => evaluacions(:one).to_param
    assert_response :success
  end

  test "should update evaluacion" do
    put :update, :id => evaluacions(:one).to_param, :evaluacion => { }
    assert_redirected_to evaluacion_path(assigns(:evaluacion))
  end

  test "should destroy evaluacion" do
    assert_difference('Evaluacion.count', -1) do
      delete :destroy, :id => evaluacions(:one).to_param
    end

    assert_redirected_to evaluacions_path
  end
end
