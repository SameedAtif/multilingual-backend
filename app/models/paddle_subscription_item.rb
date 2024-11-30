class PaddleSubscriptionItem < ApplicationRecord
  belongs_to :paddle_subscription
  belongs_to :paddle_product
  belongs_to :paddle_customer
end
