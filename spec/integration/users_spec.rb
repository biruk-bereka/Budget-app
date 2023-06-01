require 'rails_helper'

RSpec.describe User, type: :system do
  let(:user) { User.new(name: 'Biruk', email: 'biruk@example.com', password: 'password123') }

  before do
    ActionMailer::Base.deliveries.clear
    user.save
  end

  # should sign successfully
  it 'User can sign and sign in successfully' do
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
    expect(page).to have_content('Signed in successfully.')
  end
end
