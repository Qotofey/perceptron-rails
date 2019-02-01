require 'test_helper'

class PerceptronsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @perceptron = perceptrons(:one)
  end

  test "should get index" do
    get perceptrons_url, as: :json
    assert_response :success
  end

  test "should create perceptron" do
    assert_difference('Perceptron.count') do
      post perceptrons_url, params: { perceptron: { size: @perceptron.size } }, as: :json
    end

    assert_response 201
  end

  test "should show perceptron" do
    get perceptron_url(@perceptron), as: :json
    assert_response :success
  end

  test "should update perceptron" do
    patch perceptron_url(@perceptron), params: { perceptron: { size: @perceptron.size } }, as: :json
    assert_response 200
  end

  test "should destroy perceptron" do
    assert_difference('Perceptron.count', -1) do
      delete perceptron_url(@perceptron), as: :json
    end

    assert_response 204
  end
end
