Given(/^a home exists in Winnipeg$/) do
  FactoryGirl.create(:home, {name: 'Winnipeg home', street: '91 Albert St.', city: 'Winnipeg', state: 'MB', country: 'Canada'}.merge(locations[:Winnipeg]))
end

Then(/^I should( not)? see a home$/) do |negation|
  expect(page).send(negation ? :not_to : :to, have_css('#results #list .listItem'))
end

Then(/^I should see an existing home nearby$/) do
  expect(page).to have_css('#nearby .listItem')
end

Then(/^I should not see an existing home nearby$/) do
  expect(page).to have_css('#nearby .none')
end
