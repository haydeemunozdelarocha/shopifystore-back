
class ProductsController < ApplicationController
protect_from_forgery with: :null_session

def index
#         if params[:code].present?
#         # expires_at = session.extra['expires_at']
#         session = ShopifyAPI::Session.new("edicionuno.myshopify.com")

#         token = session.request_token(params)
#         granted_scopes = session.extra['scope']
#         user = session.extra['associated_user']
#         active_scopes = session.extra['associated_user_scope']
#         expires_at = session.extra['expires_at']

#         logger.info("token" + token)
#         else
# session = ShopifyAPI::Session.new("edicionuno.myshopify.com")
#   # session = ShopifyAPI::Session.setup(api_key: ENV['SHOPIFY_CLIENT_API_KEY'], secret: ENV['SHOPIFY_CLIENT_API_SECRET'])
# scope = ["write_products","read_products","read_checkouts","write_checkouts","read_orders","write_orders"]
# permission_url = session.create_permission_url(scope, "http://localhost:3000/products")
#         logger.info("token" + permission_url)

# redirect_to permission_url
#     end

session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])
        logger.info("token" + ENV['SHOPIFY_TOKEN'])

ShopifyAPI::Base.activate_session(session)
        # logger.info("shop" + session.extra['expires_at'])

shop = ShopifyAPI::Shop.current
        @products = ShopifyAPI::Product.find(:all, params: { limit: 10 })

        render json: { status: 200,
                      data: @products }

end

def create
  session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])
ShopifyAPI::Base.activate_session(session)
        # logger.info("shop" + session.extra['expires_at'])
#adds basic info
shop = ShopifyAPI::Shop.current
  new_product = ShopifyAPI::Product.new
  new_product.title = params[:title]
  new_product.product_type = params[:product_type]
  new_product.body_html = params[:description]
  new_product.variants = [{'option1':'Default',price:params[:price]}]

  new_product.save
  @product = ShopifyAPI::Product.find(new_product.id)
  #adds image
  f = File.read(params[:image])
  i = ShopifyAPI::Image.new
  i.attach_image(f) # <-- attach_image is a method, not an attribute
  @product.images << i
  @product.save
  ShopifyAPI::Base.clear_session
    render json: { status: 200,
                      data: @product }
end

def show
    session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])
  ShopifyAPI::Base.activate_session(session)
  @product_id = params[:id]

  @product = ShopifyAPI::Product.find(@product_id)

    ShopifyAPI::Base.clear_session

        render json: { status: 200,
                      data: @product }
end

def update
  session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])
  ShopifyAPI::Base.activate_session(session)
  @product_id = params[:id]

  @product = ShopifyAPI::Product.find(@product_id)
  @product.title = params[:title] || @product.title
  @product.product_type = params[:product_type] || @product.product_type
  @product.body_html = params[:description] || @product.body_html
  @product.variants = [{'option1':'Default',price: params[:price] || @product.variants[0].price}]
  @product.save
    ShopifyAPI::Base.clear_session

        render json: { status: 200,
                      data: @product }
end

def destroy
  session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])
  ShopifyAPI::Base.activate_session(session)
  @product_id = params[:id]
  @product = ShopifyAPI::Product.find(@product_id)
  ShopifyAPI::Base.clear_session

  @product.destroy
      render json: { status: 200,
                      data: true }
end
end
