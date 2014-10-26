Given(/^I click to edit from home Mission Creek Cafe$/) do
  home = Home.find_by name: "Mission Creek Cafe"
  visit home_path home
  click_link 'Contact us about this post!'
end

Then(/^I should see Mission Creek Cafe in the header$/) do
  expect(page).to have_content('Mission Creek Cafe')
end

Given(/^I click to contact from home Mission Creek Cafe$/) do
  home = Home.find_by name: "Mission Creek Cafe"
  visit home_path home
  click_link 'Contact'
end

Then(/^I should not see Mission Creek Cafe in the header$/) do
  expect(page).to have_no_content('Mission Creek Cafe')
end
