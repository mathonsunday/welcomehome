Given(/^I submit a home in Vancouver$/) do
  visit "/"
  click_link "Submit a New Home"

  fill_in "home[name]", with: "Vancouver home"
  fill_in "home[street]", with: "684 East Hastings"
  fill_in "home[city]", with: "Vancouver"
  fill_in "home[state]", with: "British Columbia"
  find(:select, "Country").first(:option, "Canada").select_option
  click_button "Save Home"
end

Then(/^I should see that the home has been created$/) do
  expect(page).to have_content("A new home entry has been created for")
end

When(/^I am in (.*) and I guess my location on the submission page$/) do |city|
  visit "/"
  click_link "Submit a New Home"

  mock_location(city.to_sym)

  find("#guess").click
end
