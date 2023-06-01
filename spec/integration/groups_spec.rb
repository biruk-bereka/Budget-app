require 'rails_helper'

RSpec.describe Group, type: :system do
    let(:user) { User.new(name: 'Biruk', email: 'biruk@example.com', password: 'password123') }
    subject { Group.new(user_id: user.id, name: 'Food', icon: 'https://image.png') }
 

  before do
    ActionMailer::Base.deliveries.clear
    user.save
    subject.save
  end
  
  # CATEGORIES INDEX PAGE 
  it 'show the categories list' do
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
    expect(page).to have_content(subject.name)
  end
  
  it 'Add a new category' do
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
    expect(page).to have_content('Food')
  end

  it 'Should be back to the categories list' do
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
    click_button 'arrow_back'
    expect(page).to have_content('Food')
  end

  it 'should not add a new category with empty name and icon' do
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
    fill_in 'name', with: ''
    fill_in 'icon', with: ''
    click_button 'ADD CATEGORY'
    expect(page).to have_content('Name can\'t be blank, Icon can\'t be blank')
  end

  it 'should not add a new category with empty name' do
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
    fill_in 'name', with: ''
    fill_in 'icon', with: 'https://image.png'
    click_button 'ADD CATEGORY'
    expect(page).to have_content('Name can\'t be blank')
  end

  it 'should not add a new category with empty icon' do
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
    fill_in 'icon', with: ''
    click_button 'ADD CATEGORY'
    expect(page).to have_content('Icon can\'t be blank')
  end
end