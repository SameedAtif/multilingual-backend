class AddViewedTutorialToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :viewed_tutorial, :boolean, default: false
  end
end
