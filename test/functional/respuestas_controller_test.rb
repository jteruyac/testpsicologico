require 'test_helper'

class RespuestasControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:respuestas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create respuesta" do
    assert_difference('Respuesta.count') do
      post :create, :respuesta => { }
    end

    assert_redirected_to respuesta_path(assigns(:respuesta))
  end

  test "should show respuesta" do
    get :show, :id => respuestas(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => respuestas(:one).to_param
    assert_response :success
  end

  test "should update respuesta" do
    put :update, :id => respuestas(:one).to_param, :respuesta => { }
    assert_redirected_to respuesta_path(assigns(:respuesta))
  end

  test "should destroy respuesta" do
    assert_difference('Respuesta.count', -1) do
      delete :destroy, :id => respuestas(:one).to_param
    end

    assert_redirected_to respuestas_path
  end
end
