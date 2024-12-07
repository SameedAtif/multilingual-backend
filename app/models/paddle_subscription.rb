class PaddleSubscription < ApplicationRecord
  belongs_to :user
  belongs_to :paddle_customer

  after_create_commit :schedule_subscription_fetch

  def schedule_subscription_fetch
    FetchPaddleSubscriptionJob.perform_at(10.minutes.from_now, transaction_id)
  end

  def unsubscribe!
    UnsubscribePaddleSubscriptionJob.perform_async(subscription_id)
  end
end
