require 'test_helper'

class PerceptronsControllerTest < ActionDispatch::IntegrationTest

  fixtures :answers
  fixtures :questions
  fixtures :perceptrons

  setup do
    @perceptron = Perceptron.new size: 3
    @perceptron.save
  end

  test "should get index" do
    get perceptrons_url, as: :json
    assert_response :success
  end

  test "should create perceptron" do
    assert_difference('Perceptron.count', 0) do
      post perceptrons_url, params: { perceptron: { size: @perceptron.size } }, as: :json
    end

    assert_response 201
    puts "Входов в персептрон: #{@perceptron.layers.first.size_inputs}"
    puts "Слов: #{Word.all.size}"
    puts "Выходов из персептрона: #{@perceptron.layers.last.size_outputs}"
  end

  test "should show perceptron" do
    get perceptron_url(@perceptron), as: :json
    assert_response :success
  end

  test "learn perceptron" do
    assert_difference('Perceptron.count', 0) do
      post learning_perceptrons_path, params: { epochs: 100 }, as: :json
    end
    assert_response 200
  end

  test "asking perceptron" do
    assert_difference('Perceptron.count', 0) do
      post asking_perceptrons_path, params: { text: "как добавить новую обучающую выборку?" }, as: :json
    end
    assert_response 200
  end

end
