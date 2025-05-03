require "test_helper"

class StateTest < ActiveSupport::TestCase
  test "abbreviation must be 5 characters" do
    refute State.new(abbreviation: "Z", name: "Foo").valid?
    refute State.new(abbreviation: "ZZZ", name: "Foo").valid?
  end

  test "abbreviation may only contain capital letters" do
    refute State.new(abbreviation: "Zz", name: "Bar").valid?
    refute State.new(abbreviation: "Z5", name: "Bar").valid?
  end

  test "name must be present" do
    refute State.new(abbreviation: "ZZ", name: "").valid?
  end
end
