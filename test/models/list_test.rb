require 'test_helper'

class ListTest < ActiveSupport::TestCase
  fixtures :users
  fixtures :lists
  fixtures :items

  def setup
    @list_with_items = FactoryGirl.build(:with_items)
  end

  test "validate title presence" do
    list = FactoryGirl.build(:without_title)
    assert list.invalid?
    assert !list.save
    assert_equal ["can't be blank"], list.errors[:title]
  end

  test "validate title uniqueness" do
    list = FactoryGirl.build(:with_same_title)
    assert list.invalid?
    assert !list.save
    assert_equal ["has already been taken"], list.errors[:title]
  end

  test "lists are ordered by created_at column" do
    lists = List.including_items
    assert_equal [lists(:second), lists(:fourth), lists(:third), lists(:first), lists(:fifth)], lists
  end

  test "list contains it's items" do
    assert_includes list_with_items.items, items(:first)
    assert_includes list_with_items.items, items(:second)
  end

  test "list belongs to user" do
    assert_equal users(:first), list_with_items.user
  end

  test "list items are destroyed when destroy list" do
    list_with_items.destroy

    assert_equal [], list_with_items.items
  end

  private

  attr_reader :list_with_items
end
