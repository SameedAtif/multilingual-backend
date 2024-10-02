class AddLanguageToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :language, :string, default: "en", null: false
  end
end
