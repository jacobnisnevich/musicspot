require 'test_helper'

class GroupTest < ActiveSupport::TestCase

  def setup
    @group = Group.new(
      name: "Awechords",
      location: "90024",
      description: "We like to sing.",
      group_type: "Acapella")
  end

  test "valid group" do
    assert @group.valid?
  end

  test "group name should be present" do
    @group.name = ""
    assert_not @group.valid?
  end

  test "group location should be present" do
    @group.location = ""
    assert_not @group.valid?
  end

  test "group type should be present" do
    @group.group_type = ""
    assert_not @group.valid?
  end

  test "group name should not be too long" do
    @group.name = "a" * 51
    assert_not @group.valid?
  end

  test "zip validation should reject invalid zip codes" do
    invalid_zips = %w[1 123456789 Seattle]
    invalid_zips.each do |invalid_zip|
      @group.location = invalid_zip
      assert_not @group.valid?, "#{invalid_zip.inspect} should be invalid"
    end
  end
end
