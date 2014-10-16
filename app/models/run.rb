class Run < ActiveRecord::Base
  belongs_to :web_test
  belongs_to :first_view, class_name: 'Result', autosave: true
  belongs_to :repeat_view, class_name: 'Result', autosave: true
end
