class OrdersController < ApplicationController
  protect_from_forgery with: :null_session

def index
session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])

ShopifyAPI::Base.activate_session(session)

shop = ShopifyAPI::Shop.current
        @orders = ShopifyAPI::Order.find(:all, params: { limit: 10 })

        render json: { status: 200,
                      data: @orders }
end

def create
session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])

ShopifyAPI::Base.activate_session(session)

@product = ShopifyAPI::Product.find(params[:product])


order = ShopifyAPI::Order.new(
  :line_items => [
    ShopifyAPI::LineItem.new(
      :quantity => 1,
      :variant_id => @product.variants.first.id
    )
  ],
  :email => params[:email]
)


order.save
p order.save
# transaction = ShopifyAPI::Transaction.new(
#   :payment_details => [
#     ShopifyAPI::PaymentDetail.new(:avs_result_code => "null",
#     :credit_card_bin => "null",
#     :cvv_result_code => "null",
#     :credit_card_number => "•••• •••• •••• 4242",
#     :credit_card_company => "Visa")
#   ],
#   :amount => "10.00",
#   :authorization => "null",
#   :created_at => "2012-03-13T16:09:54-04:00",
#   :kind => "capture",
#   :order_id => order.id,
#   :status => "success",
#   :currency => "USD"

# )

# transaction.save
# p transaction.save
      ShopifyAPI::Base.clear_session
        render json: { status: 200,
                      data: order }

end

def show
  session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])
  ShopifyAPI::Base.activate_session(session)
  @order_id = params[:id]

  @order = ShopifyAPI::Order.find(@order_id)

    ShopifyAPI::Base.clear_session

        render json: { status: 200,
                      data: @order }
end


end
