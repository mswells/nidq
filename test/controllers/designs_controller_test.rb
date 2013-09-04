require 'test_helper'

class DesignsControllerTest < ActionController::TestCase
  setup do
    @design = designs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:designs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create design" do
    assert_difference('Design.count') do
      post :create, design: { consumerName: @design.consumerName, designId: @design.designId, metricId: @design.metricId, productName: @design.productName, status: @design.status, timestamp: @design.timestamp }
    end

    assert_redirected_to design_path(assigns(:design))
  end

  test "should show design" do
    get :show, id: @design
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @design
    assert_response :success
  end

  test "should update design" do
    patch :update, id: @design, design: { consumerName: @design.consumerName, designId: @design.designId, metricId: @design.metricId, productName: @design.productName, status: @design.status, timestamp: @design.timestamp }
    assert_redirected_to design_path(assigns(:design))
  end

  test "should destroy design" do
    assert_difference('Design.count', -1) do
      delete :destroy, id: @design
    end

    assert_redirected_to designs_path
  end
end
