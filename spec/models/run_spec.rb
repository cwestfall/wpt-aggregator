require 'rails_helper'

RSpec.describe Run, :type => :model do

  let(:run) {
    create(:run)
  }

  it 'has a valid factory' do
    expect(run).to be_valid
  end

  it 'should belong to WebTest' do
    expect(run).to belong_to(:web_test)
  end

  it 'should have a first view' do
    expect(run).to belong_to(:first_view)
  end

  it 'should have a first view' do
    expect(run).to belong_to(:repeat_view)
  end

end
