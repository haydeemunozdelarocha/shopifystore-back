class PaymentsController < ApplicationController
  protect_from_forgery with: :null_session

      def index
      session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])

ShopifyAPI::Base.activate_session(session)

shop = ShopifyAPI::Shop.current
    @application_charges = ShopifyAPI::ApplicationCharge.all || []
      render json: { status: 200,
                      data: @application_charges }
  end

  def create
      session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])

      ShopifyAPI::Base.activate_session(session)

      shop = ShopifyAPI::Shop.current

    application_charge = ShopifyAPI::ApplicationCharge.new(params[:application_charge])
    application_charge.test = true
    application_charge.return_url = "http://localhost:3000/products"

    if application_charge.save
       render json: { status: 200,
                      data: application_charge }
    else
      render json: { status: 500,
                      data: false }
    end
  end

  def activate
          session = ShopifyAPI::Session.new("edicionuno.myshopify.com", ENV['SHOPIFY_TOKEN'])

      ShopifyAPI::Base.activate_session(session)

      shop = ShopifyAPI::Shop.current

    application_charge = ShopifyAPI::ApplicationCharge.find(params[:id])
    if application_charge.activate
      flash[:success] = "One-time charge has been activated"
    end

    redirect_to application_charges_path
  end

  private

  def application_charge_params
    params.require(:application_charge).permit(
      :name,
      :price
    )
  end
end
