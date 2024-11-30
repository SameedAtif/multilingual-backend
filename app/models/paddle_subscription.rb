class PaddleSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :paddle_customer
end
