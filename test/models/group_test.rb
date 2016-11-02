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

  test "group name should not be too long" do
    @group.name = "a" * 51
    assert_not @group.valid?
  end

  test "group location should not be too long" do
    @group.location = "1" * 51
    assert_not @group.valid?
  end
end
