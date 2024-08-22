class CreateShopifySessionTable < ActiveRecord::Migration[7.1]
  def change
    create_table :shopify_sessions, id: false do |t|
      t.string :id, primary_key: true
      t.string :shop
      t.string :state
      t.boolean :is_online, default: false
      t.string :scope
      t.datetime :expires
      t.string :access_token
      t.belongs_to :user, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.string :email
      t.boolean :account_owner
      t.string :locale
      t.boolean :collaborator
      t.boolean :email_verified
    end
  end
end

# model Session {
# id            String    @id
# shop          String
# state         String
# isOnline      Boolean   @default(false)
# scope         String?
# expires       DateTime?
# accessToken   String
# userId        BigInt?
# firstName     String?
# lastName      String?
# email         String?
# accountOwner  Boolean   @default(false)
# locale        String?
# collaborator  Boolean?  @default(false)
# emailVerified Boolean?  @default(false)
