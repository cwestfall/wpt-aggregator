class Result < ActiveRecord::Base
  has_one :first_view, class_name: 'Run', foreign_key: :first_view_id
  has_one :repeat_view, class_name: 'Run', foreign_key: :repeat_view_id
end
