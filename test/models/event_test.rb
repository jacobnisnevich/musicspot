require 'test_helper'

class EventTest < ActiveSupport::TestCase

  def setup
    @event = Event.new(
      name: "Band Concert",
      location: "90024",
      start_datetime: DateTime.new(2016,10,30,15),
      end_datetime: DateTime.new(2016,10,30,16),
      description: "An awesome concert.")
  end

  test "valid event" do
    assert @event.valid?
  end

  test "event name should be present" do
    @event.name = ""
    assert_not @event.valid?
  end

  test "event location should be present" do
    @event.location = ""
    assert_not @event.valid?
  end

  test "event name should not be too long" do
    @event.name = "a" * 51
    assert_not @event.valid?
  end

  test "zip validation should reject invalid zip codes" do
    invalid_zips = %w[1 123456789 Seattle]
    invalid_zips.each do |invalid_zip|
      @event.location = invalid_zip
      assert_not @event.valid?, "#{invalid_zip.inspect} should be invalid"
    end
  end
end
