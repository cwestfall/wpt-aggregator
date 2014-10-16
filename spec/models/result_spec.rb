require 'rails_helper'

RSpec.describe Result, :type => :model do

  it 'has a valid factory' do
    expect(create(:result)).to be_valid
  end

  it 'should be a first view result' do
    expect(create(:result)).to have_one :first_view
  end

  it 'should be a repeat view result' do
    expect(create(:result)).to have_one :repeat_view
  end

end
