require 'test_helper'

class NotifierTest < ActionController::TestCase
  test "should return flash alert" do
    flash[:alert] = 'alert message'
    message = Notifier.new flash
    assert_equal 'alert message', message.alert
  end

  test "should return nil on empty flash" do
    message = Notifier.new flash
    assert_nil message.alert
  end
end
