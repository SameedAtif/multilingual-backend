class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :validatable, :invitable

  belongs_to :organization, optional: true

  has_one :owned_org, foreign_key: "owner_id", class_name: "Organization", dependent: :destroy

  has_many :messages, dependent: :destroy
  has_many :participants, dependent: :destroy
  has_many :rooms, through: :participants
  has_many :refresh_tokens, dependent: :delete_all
  has_many :whitelisted_tokens, dependent: :delete_all
  has_many :blacklisted_tokens, dependent: :delete_all
  has_many :paddle_customers, dependent: :destroy
  has_many :paddle_subscriptions, dependent: :destroy
  has_many :paddle_checkout_responses, dependent: :destroy

  enum user_type: {
    internal: 0, # We have a password for them
    external: 1 # Shopify user, guest user (we don't have a password for them)
  }

  protected

  def password_required?
    return false if external?

    super
  end
end
