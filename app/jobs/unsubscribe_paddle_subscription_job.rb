class UnsubscribePaddleSubscriptionJob
  include ActionView::RecordIdentifier
  include Sidekiq::Worker

  sidekiq_options queue: :default
  sidekiq_options retry: false

  def perform(subscription_id)
    response = HTTParty.post(
      "https://sandbox-api.paddle.com/subscriptions/#{subscription_id}/cancel",
      headers: {
        'Authorization' => "Bearer #{ENV['PADDLE_AUTH']}"
      }
    ).parsed_response
    if response.dig("data", "status") == "cancelled"
      PaddleSubscription.find_by(subscription_id: subscription_id).update!(
        transaction_status: response.dig("data", "status")
      )
    elsif response.dig("data", "status") == "active" && response.dig("data", "scheduled_change").present?
      # Schedule unsubscription
      scheduled_time = Time.parse(response.dig("data", "scheduled_change", "effective_at"))
      UnsubscribePaddleSubscriptionJob.perform_at(scheduled_time, subscription_id)
    end
  end
end
