require 'spec_helper'

feature "User registers", {js:true, vcr:true } do
  background do
    visit register_path
  end

  scenario "with valid user info and valid card" do
    fill_in_valid_user_info
    fill_in_valid_card_info
    sign_in
    expect(page).to have_content("Thank you for registering with MyFlix. Please sign in!")
  end

  scenario "with valid user info and invalid card" do
    fill_in_valid_user_info
    fill_in_invalid_card_info
    sign_in
    expect(page).to have_content("This card number looks invalid")
  end

  scenario "with valid user info and declined card" do
    fill_in_valid_user_info
    fill_in_declined_card_info
    sign_in
    expect(page).to have_content("Your card was declined.")
  end

  scenario "with invalid user info and valid card" do
    fill_in_invalid_user_info
    fill_in_valid_card_info
    sign_in
    expect(page).to have_content("Invalid user information.  Please check the errors below.")
  end

  scenario "with invalid user info and invalid card" do
    fill_in_invalid_user_info
    fill_in_invalid_card_info
    sign_in
    expect(page).to have_content("This card number looks invalid")
  end

  scenario "with invalid user info and declined card" do
    fill_in_invalid_user_info
    fill_in_declined_card_info
    sign_in
    expect(page).to have_content("Invalid user information.  Please check the errors below.")
  end

  def sign_in
    click_button "Sign Up"
  end

  def fill_in_valid_user_info
    fill_in "Email Address", with: "john@example.com"
    fill_in "Password", with: "password"
    fill_in "Full Name", with: "John Doe"
  end

  def fill_in_valid_card_info
    fill_in "Credit Card Number", with: "4242424242424242"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
  end

  def fill_in_invalid_card_info
    fill_in "Credit Card Number", with: "123"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
  end

  def fill_in_declined_card_info
    fill_in "Credit Card Number", with: "4000000000000002"
    fill_in "Security Code", with: "123"
    select "7 - July", from: "date_month"
    select "2018", from: "date_year"
  end

  def fill_in_invalid_user_info
    fill_in "Email Address", with: "john@example.com"
  end

end