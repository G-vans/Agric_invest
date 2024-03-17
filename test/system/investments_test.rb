require "application_system_test_case"

class InvestmentsTest < ApplicationSystemTestCase
  setup do
    @investment = investments(:one)
  end

  test "visiting the index" do
    visit investments_url
    assert_selector "h1", text: "Investments"
  end

  test "should create investment" do
    visit investments_url
    click_on "New investment"

    fill_in "Amount", with: @investment.amount
    fill_in "Description", with: @investment.description
    fill_in "Image url", with: @investment.image_url
    fill_in "Title", with: @investment.title
    click_on "Create Investment"

    assert_text "Investment was successfully created"
    click_on "Back"
  end

  test "should update Investment" do
    visit investment_url(@investment)
    click_on "Edit this investment", match: :first

    fill_in "Amount", with: @investment.amount
    fill_in "Description", with: @investment.description
    fill_in "Image url", with: @investment.image_url
    fill_in "Title", with: @investment.title
    click_on "Update Investment"

    assert_text "Investment was successfully updated"
    click_on "Back"
  end

  test "should destroy Investment" do
    visit investment_url(@investment)
    click_on "Destroy this investment", match: :first

    assert_text "Investment was successfully destroyed"
  end
end
