class AddDomElementsToResult < ActiveRecord::Migration
  def change
    add_column :results, :dom_elements, :integer
  end
end
