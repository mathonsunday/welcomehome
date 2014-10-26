Then(/^I should see that I am at (.*)$/) do |address|
  expect(page).to have_field('home[street]', with: address)
end

Then(/^I should see that I am in ([^,]*), ([^,]*), ([^,]*)$/) do |city, region, country|
  expect(page).to have_field('home[city]', with: city)
  expect(page).to have_field('home[state]', with: region)
  expect(page).to have_field('home[country]', with: country)
end
