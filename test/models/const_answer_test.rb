require 'test_helper'

class ConstAnswerTest < ActiveSupport::TestCase

  test "достаточно отправить лишь аргумент text" do
    answer = ConstAnswer.new text: 'Для добавления новой выборки нажмите на кнопку "+" в правом нижнем углу'
    assert true

  end
end
