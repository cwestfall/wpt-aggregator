class TestSuite < ActiveRecord::Base
  validates_presence_of :label
  has_many :web_test, :dependent => :destroy

  def execute

  end

end
