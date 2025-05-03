require "test_helper"

class AddressTest < ActiveSupport::TestCase
  setup do
    @state = states(:one)
    @zip_code = zip_codes(:one)
  end

  test "line_1 must be present" do
    refute Address.new(line_1: "",
                       city: "Hometown",
                       state: @state,
                       zip_code: @zip_code).valid?
  end

  test "city must be present" do
    refute Address.new(line_1: "123 Main Street",
                       city: "Hometown",
                       state: nil,
                       zip_code: @zip_code).valid?
  end

  test "state must be present" do
    refute Address.new(line_1: "123 Main Street",
                       city: "Hometown",
                       state: @state,
                       zip_code: nil).valid?
  end

  test "zip_code must be present" do
    refute Address.new(line_1: "123 Main Street",
                       city: "",
                       state: @state,
                       zip_code: @zip_code).valid?
  end
end
