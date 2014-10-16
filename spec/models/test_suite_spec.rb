require 'rails_helper'

RSpec.describe TestSuite, :type => :model do
  it 'has a valid factory' do
    expect(create(:test_suite)).to be_valid
  end

  it 'is invalid without a label' do
    expect(build(:test_suite, label: nil)).not_to be_valid
  end

  it 'should have many WebTests' do
    expect(create(:test_suite)).to have_many(:web_test)
  end

  describe 'execution of WebTests' do
    it 'should call execute on all child WebTests' do
      skip('Implement test that will validate execute has been called on each child')
    end
  end
end
