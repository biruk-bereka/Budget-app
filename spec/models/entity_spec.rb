require 'rails_helper'

RSpec.describe Entity, type: :model do
  let(:user) { User.new(name: 'Biruk', email: 'biruk@example.com', password: 'biruk12') }
  subject { Entity.new(user_id: user.id, name: 'Burger', amount: 10.0) }

  before do
    user.save
    subject.save
  end

  it 'Name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'Amount should be present' do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it 'Amount should be greater than 0' do
    subject.amount = 0
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

   it 'Both name and amount should be present' do
      subject.name = nil
      subject.amount = nil
      expect(subject).to_not be_valid
   end
   
   it 'Both name and amount are present' do
      expect(subject).to be_valid
   end

end
