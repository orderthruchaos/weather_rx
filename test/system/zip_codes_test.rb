require "application_system_test_case"

class ZipCodesTest < ApplicationSystemTestCase
  setup do
    @zip_code = zip_codes(:one)
  end

  test "visiting the index" do
    visit zip_codes_url
    assert_selector "h1", text: "Zip codes"
  end

  test "should create zip code" do
    visit zip_codes_url
    click_on "New zip code"

    fill_in "Code", with: "99999"
    click_on "Create Zip code"

    assert_text "Zip code was successfully created"
    click_on "Back"
  end

  test "should update Zip code" do
    visit zip_code_url(@zip_code)
    click_on "Edit this zip code", match: :first

    fill_in "Code", with: @zip_code.code
    click_on "Update Zip code"

    assert_text "Zip code was successfully updated"
    click_on "Back"
  end

  test "should destroy Zip code" do
    visit zip_code_url(@zip_code)
    click_on "Destroy this zip code", match: :first

    assert_text "Zip code was successfully destroyed"
  end
end
