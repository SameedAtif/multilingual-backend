class PaddleCustomer < ApplicationRecord
  belongs_to :user

  has_many :paddle_subscriptions
  has_many :paddle_subscription_items
end
