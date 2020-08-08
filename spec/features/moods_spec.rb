require 'rails_helper'

RSpec.feature "Moods", type: :feature do
  scenario "user login" do
    user = FactoryBot.create(:user)

    visit root_path

    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Login"

    expect(page).to have_content "Signed in successfully"
  end
end


#   scenario "user adds new mood" do
#     user = FactoryBot.create(:user)

#     visit root_path

#     click_link "Login"
#     fill_in "Email", with: user.email
#     fill_in "Password", with: user.password

#     click_button "Login"

#     click_link "fabulous-link"
#     check('sleep')
#     within('.form-btn-container') do
#       click_button "Create mood"
#     end
#     expect(page).to have_content "Fabulous"
#   end
# end
