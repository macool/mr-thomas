require 'test_helper'

class SubscriberTest < ActiveSupport::TestCase
  test "token gets generated before save" do
    subscriber = Subscriber.new
    subscriber.save
    assert subscriber.token
  end

  test "unique token is automatically generated" do
    Subscriber.create
    subscriber = Subscriber.new
    assert subscriber.save
    assert subscriber.token
  end 
end
