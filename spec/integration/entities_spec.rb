require 'rails_helper'

RSpec.describe Entity, type: :system do
  let(:user) { User.new(name: 'Biruk', email: 'biruk@example.com', password: 'password123') }

  before do
    ActionMailer::Base.deliveries.clear
    user.save
  end

  # TRANSACTION INDEX PAGE
  it 'show the transactions list' do
    visit new_user_registration_path
    # Fill in the sign-in form with valid user credentials
    fill_in 'Full name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Confirm password', with: user.password
    click_button 'SIGN UP'

    # Retrieve the confirmation email
    path_regex = %r{(?:"https?://.*?)(/.*?)(?:")}
    email = ActionMailer::Base.deliveries.last
    path = email.body.match(path_regex)[1]

    # Visit the confirmation link
    visit path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'LOG IN'
    sleep(5)
    visit groups_path
    click_button 'ADD NEW CATEGORY'
    fill_in 'name', with: 'Food'
    fill_in 'icon', with: 'https://image.png'
    click_button 'ADD CATEGORY'

    # click on name of the category
    click_link 'Food'
    expect(page).to have_content('NO TRANSACTIONS YET!')
  end

  it 'Add a new transaction' do
    visit new_user_registration_path
    # Fill in the sign-in form with valid user credentials
    fill_in 'Full name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Confirm password', with: user.password
    click_button 'SIGN UP'

    # Retrieve the confirmation email
    path_regex = %r{(?:"https?://.*?)(/.*?)(?:")}
    email = ActionMailer::Base.deliveries.last
    path = email.body.match(path_regex)[1]

    # Visit the confirmation link
    visit path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'LOG IN'
    sleep(5)
    visit groups_path
    click_button 'ADD NEW CATEGORY'
    fill_in 'name', with: 'Food'
    fill_in 'icon', with: 'https://image.png'
    click_button 'ADD CATEGORY'

    # click on name of the category
    click_link 'Food'
    click_button 'ADD NEW TRANSACTION'
    sleep(5)
    fill_in 'name', with: 'Burger'
    fill_in 'amount', with: 10.0
    click_button 'ADD TRANSACTION'
    expect(page).to have_content('Burger')
  end

  it 'should not add a new transaction with empty amount' do
    visit new_user_registration_path
    # Fill in the sign-in form with valid user credentials
    fill_in 'Full name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Confirm password', with: user.password
    click_button 'SIGN UP'

    # Retrieve the confirmation email
    path_regex = %r{(?:"https?://.*?)(/.*?)(?:")}
    email = ActionMailer::Base.deliveries.last
    path = email.body.match(path_regex)[1]

    # Visit the confirmation link
    visit path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'LOG IN'
    sleep(5)
    visit groups_path
    click_button 'ADD NEW CATEGORY'
    fill_in 'name', with: 'Food'
    fill_in 'icon', with: 'https://image.png'
    click_button 'ADD CATEGORY'

    # click on name of the category
    click_link 'Food'
    click_button 'ADD NEW TRANSACTION'
    sleep(5)
    fill_in 'name', with: 'Burger'
    fill_in 'amount', with: nil
    click_button 'ADD TRANSACTION'
    expect(page).to have_content('Amount can\'t be blank')
  end

  it 'should not add a new transaction with empty name' do
    visit new_user_registration_path
    # Fill in the sign-in form with valid user credentials
    fill_in 'Full name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Confirm password', with: user.password
    click_button 'SIGN UP'

    # Retrieve the confirmation email
    path_regex = %r{(?:"https?://.*?)(/.*?)(?:")}
    email = ActionMailer::Base.deliveries.last
    path = email.body.match(path_regex)[1]

    # Visit the confirmation link
    visit path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'LOG IN'
    sleep(5)
    visit groups_path
    click_button 'ADD NEW CATEGORY'
    fill_in 'name', with: 'Food'
    fill_in 'icon', with: 'https://image.png'
    click_button 'ADD CATEGORY'

    # click on name of the category
    click_link 'Food'
    click_button 'ADD NEW TRANSACTION'
    sleep(5)
    fill_in 'name', with: nil
    fill_in 'amount', with: 10.0
    click_button 'ADD TRANSACTION'
    expect(page).to_not have_content('Name can\'t be blank')
  end

  it 'should not add a new transaction with empty name and amount' do
    visit new_user_registration_path
    # Fill in the sign-in form with valid user credentials
    fill_in 'Full name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Confirm password', with: user.password
    click_button 'SIGN UP'

    # Retrieve the confirmation email
    path_regex = %r{(?:"https?://.*?)(/.*?)(?:")}
    email = ActionMailer::Base.deliveries.last
    path = email.body.match(path_regex)[1]

    # Visit the confirmation link
    visit path

    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_button 'LOG IN'
    sleep(5)
    visit groups_path
    click_button 'ADD NEW CATEGORY'
    fill_in 'name', with: 'Food'
    fill_in 'icon', with: 'https://image.png'
    click_button 'ADD CATEGORY'

    # click on name of the category
    click_link 'Food'
    click_button 'ADD NEW TRANSACTION'
    sleep(5)
    fill_in 'name', with: nil
    fill_in 'amount', with: nil
    click_button 'ADD TRANSACTION'
    expect(page).to have_content('Name can\'t be blank, Amount can\'t be blank')
  end
end
