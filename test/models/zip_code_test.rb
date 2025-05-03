require "test_helper"

class ZipCodeTest < ActiveSupport::TestCase
  test "must be 5 characters" do
    refute ZipCode.new(code: "0000").valid?
    refute ZipCode.new(code: "000000").valid?
  end

  test "may only contain digits" do
    refute ZipCode.new(code: "00 00").valid?
    refute ZipCode.new(code: "00A00").valid?
  end
end
