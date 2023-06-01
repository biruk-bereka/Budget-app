require 'rails_helper'

RSpec.describe Group, type: :model do
  let(:user) { User.new(name: 'Biruk', email: 'biruk@example.com', password: 'biruk12') }
  subject { Group.new(user_id: user.id, name: 'Food', icon: 'https://image.png') }

  before do
    user.save
    subject.save
  end

  it 'Name should be present'  do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Icon should be present' do
    subject.icon = nil
    expect(subject).to_not be_valid
  end

  it 'Name should be less than 250 characters, expected false' do
    t = 'This must be a very long text to test the max length of a post it is supouse to be less than 250'
    t1 = 'character, for that i am goint to improvise some custom text, and this test'
    t2 = 'must be false because we are passing rigth know the 200 hundred characters and we are '
    t3 = 'close to our goal, Yes we did it!!!'
    subject.name = t + t1 + t2 + t3
    expect(subject).to_not be_valid
  end
  
  it 'Icon should be any length' do
    t = 'This must be a very long text to test the max length of a post it is supouse to be less than 250'
    t1 = 'character, for that i am goint to improvise some custom text, and this test'
    t2 = 'must be false because we are passing rigth know the 200 hundred characters and we are '
    t3 = 'close to our goal, Yes we did it!!!'
    subject.icon = t + t1 + t2 + t3
    expect(subject).to  be_valid
  end

   it 'Both name and icon should be present' do
      subject.name = nil
      subject.icon = nil
      expect(subject).to_not be_valid
   end
   
   it 'Both name and icon are present' do
      expect(subject).to be_valid
   end
end
