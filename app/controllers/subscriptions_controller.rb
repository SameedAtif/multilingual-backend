class SubscriptionsController < ApplicationController
  protect_from_forgery with: :null_session, only: [:create] # Or use `protect_from_forgery` only for specific APIs

  def new; end

  def create
    create_paddle_products!
    paddle_customer = current_user.paddle_customers.find_or_create_by!(customer_information)
    @paddle_subscription = create_paddle_subscription!(paddle_customer)
    redirect_to rooms_path, notice: "You have successfully subscribed to the plan"
  end

  private

  def customer_information
    customer_information = params.dig("data", "customer").transform_keys("id" => "customer_id")
    address_information = customer_information.delete("address")
    address_information.delete("id")
    customer_information.delete("business")
    customer_information.merge!(address_information)
  end

  def create_paddle_products!
    params.dig("data", "items").each do |item|
      paddle_product = item.dig("product").transform_keys("id" => "product_id")
      paddle_product.delete("image_url")
      PaddleProduct.find_or_create_by!(paddle_product)
    end
  end

  def create_paddle_subscription!(paddle_customer)
    subscription_information = params.dig("data").except("id", "customer", "items", "settings", "recurring_totals", "custom_data")
    totals =subscription_information.delete("totals").except("balance", "credit")
    payment_method = subscription_information.dig("payment", "method_details").transform_keys("type" => "payment_method_type")
    card_details = payment_method.delete("card").transform_keys { |key| "card_#{key}" }
    subscription_information.merge!(totals, payment_method, card_details, paddle_customer_id: paddle_customer.id)
    current_user.paddle_subscription.find_or_create_by!(subscription_information.except("payment"))
  end
end
