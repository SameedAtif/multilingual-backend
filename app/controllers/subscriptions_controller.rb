class SubscriptionsController < ApplicationController
  protect_from_forgery with: :null_session, only: [:create] # Or use `protect_from_forgery` only for specific APIs

  def new; end

  def create
    create_paddle_products!
    paddle_customer = current_user.paddle_customers.find_or_create_by!(customer_information)
    @paddle_subscription = create_paddle_subscription!(paddle_customer)

    render json: { redirect_url: rooms_path }, status: :ok
  end

  private

  def customer_information
    customer_information = params.dig("data", "customer").permit!.to_h.transform_keys("id" => "customer_id")
    address_information = customer_information.delete("address")
    address_information.delete("id")
    customer_information.delete("business")
    customer_information.merge!(address_information)
  end

  def create_paddle_products!
    params.dig("data", "items").each do |item|
      paddle_product = item.dig("product").permit!.to_h.transform_keys("id" => "product_id")
      paddle_product.delete("image_url")
      PaddleProduct.find_or_create_by!(paddle_product)
    end
  end

  def create_paddle_subscription!(paddle_customer)
    subscription_information = params.dig("data").except("id", "customer", "items", "settings", "recurring_totals", "custom_data")
    totals =subscription_information.delete("totals").except("balance", "credit")
    payment_method = subscription_information.dig("payment", "method_details").permit!.to_h.transform_keys("type" => "payment_method_type")
    card_details = payment_method.delete("card").transform_keys { |key| "card_#{key}" }
    payload = subscription_information.to_unsafe_h.merge(totals.to_unsafe_h, payment_method, card_details).except("payment")
    obj = current_user.paddle_subscriptions.find_or_initialize_by(payload)
    obj.paddle_customer = paddle_customer

    obj.save!
  end
end
