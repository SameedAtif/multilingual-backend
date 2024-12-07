module Api
  module V1
    class PaddlesController < ApplicationController
      skip_before_action :authenticate

      def notification
        case params["event_type"]
        when "subscription.past_due", "subscription.updated", "subscription.created"
          subscription_updated
        when "transaction.updated", "transaction.paid", "transaction.completed"
          transaction_updated
        end
      end

      private

      def subscription_updated
        PaddleSubscription.find_by(
          subscription_id: params.dig("data", "id")
        )&.update!(
          status: params.dig("data", "status"),
          next_billed_at: params.dig("data", "next_billed_at")
        )

        render json: { message: "Subscription updated" }, status: :ok
      end

      def transaction_updated
        PaddleSubscription.find_by(
          transaction_id: params.dig("data", "id")
        ).or(
          PaddleSubscription.find_by(
            subscription_id: params.dig("data", "subscription_id")
          )
        )&.update!(
          transcation_status: params.dig("data", "status")
        )

        render json: { message: "Transaction updated" }, status: :ok
      end
    end
  end
end
