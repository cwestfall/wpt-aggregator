require 'rails_helper'

describe 'TestSuites', :type => :feature do

  describe 'CRUD operations' do
    it 'displays the current Test Suites' do
      create(:test_suite, label: 'Google Suite')

      visit test_suites_path
      expect(page).to have_content('Google Suite')
    end
  end
end
