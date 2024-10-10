class AddTokenBasedAuth < ActiveRecord::Migration[7.1]
  def change
    create_table :blacklisted_tokens, id: :uuid do |t|
      t.string :jti
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.datetime :exp

      t.timestamps
    end

    create_table :whitelisted_tokens, id: :uuid do |t|
      t.string :jti
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid
      t.datetime :exp

      t.timestamps
    end

    create_table :refresh_tokens, id: :uuid do |t|
      t.string :crypted_token
      t.datetime :expires_at
      t.belongs_to :user, null: false, foreign_key: true, type: :uuid

      t.timestamps
    end

    add_column :users, :token_issued_at, :datetime
    #Ex:- add_column("admin_users", "username", :string, :limit =>25, :after => "email")
    add_index :refresh_tokens, :crypted_token, unique: true
    add_index :whitelisted_tokens, :jti, unique: true
    add_index :blacklisted_tokens, :jti, unique: true
  end
end
