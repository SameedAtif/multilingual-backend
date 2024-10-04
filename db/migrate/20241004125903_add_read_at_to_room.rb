class AddReadAtToRoom < ActiveRecord::Migration[7.1]
  def change
    add_column :rooms, :read_at, :datetime
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
  end
end
