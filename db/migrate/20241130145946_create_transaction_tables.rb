class CreateTransactionTables < ActiveRecord::Migration[7.1]
  def change
    create_table :paddle_checkout_responses do |t|
      t.references :user
      t.jsonb :response

      t.timestamps
    end

    create_table :paddle_products, id: :uuid do |t|
      t.string :product_id
      t.string :name
      t.string :description

      t.timestamps
    end

    create_table :paddle_customers, id: :uuid do |t|
      t.references :user

      t.string :customer_id
      t.string :email
      t.string :country_code
      t.string :postal_code
      t.string :city
      t.string :region
      t.string :first_line

      t.timestamps
    end

    create_table :paddle_subscriptions, id: :uuid do |t|
      t.references :user
      t.references :paddle_customer

      t.decimal :total
      t.decimal :tax
      t.decimal :discount
      t.decimal :subtotal

      t.string :status
      t.string :transaction_id
      t.string :transaction_status
      t.string :currency_code
      t.string :payment_method_type
      t.string :card_type
      t.string :card_last4
      t.string :card_expiry_month
      t.string :card_expiry_year

      t.timestamps
    end

    create_table :paddle_subscription_items, id: :uuid do |t|
      t.references :paddle_subscription
      t.references :paddle_product
      t.references :paddle_customer

      t.string :price_id
      t.string :price_name
      t.string :billing_cycle_interval
      t.string :billing_cycle_frequency
      t.string :trial_period

      t.decimal :total
      t.decimal :tax
      t.decimal :discount
      t.decimal :subtotal

      t.timestamps
    end
  end
end
