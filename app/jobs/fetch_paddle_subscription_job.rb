class FetchPaddleSubscriptionJob
  include ActionView::RecordIdentifier
  include Sidekiq::Worker

  sidekiq_options queue: :default
  sidekiq_options retry: false

  def perform(transaction_id)
    response = HTTParty.get(
      "#{ENV['PADDLE_BASE_URL']}/transactions/#{transaction_id}",
      headers: {
        'Authorization' => "Bearer #{ENV['PADDLE_AUTH']}"
      }
    ).parsed_response

    PaddleSubscription.find_by(transaction_id: transaction_id).update!(
      subscription_id: response.dig("data", "subscription_id"),
      next_billed_at: response.dig("data", "next_billed_at"),
      transaction_status: response.dig("data", "status")
    )
  end
end
