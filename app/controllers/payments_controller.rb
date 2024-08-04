# app/controllers/payments_controller.rb
class PaymentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.find(params[:order_id])
    @amount = (@order.total_amount * 100).to_i # Amount in cents

    if params[:use_stripe] == 'true'
      begin
        # Create a PaymentIntent with Stripe only if the order doesn't already have one
        unless @order.payment_intent_id.present?
          payment_intent = Stripe::PaymentIntent.create(
            amount: @amount,
            currency: 'usd',
            payment_method_types: ['card'],
            metadata: { order_id: @order.id }
          )
          @order.update(payment_intent_id: payment_intent.id)
        else
          payment_intent = Stripe::PaymentIntent.retrieve(@order.payment_intent_id)
        end

        # Retrieve the client secret for client-side use
        @client_secret = payment_intent.client_secret
        Rails.logger.debug "Client Secret payment controller: #{@client_secret}" # Debugging: Log the client_secret
      rescue Stripe::StripeError => e
        flash[:error] = e.message
        redirect_to new_order_payment_path(@order)
      end
    else
      # Payment is optional; proceed without Stripe
      @client_secret = nil
    end
  end

  def confirm
    @order = Order.find(params[:order_id]) # Ensure the order is retrieved

    if params[:use_stripe] == true
      payment_id = params[:payment_id]
      payment_intent = Stripe::PaymentIntent.retrieve(payment_id)

      if payment_intent.status == 'succeeded'
        @order.update(status: :paid_order) # Update order status to 'paid_order'
        flash[:notice] = 'Payment confirmed and order marked as paid.'
      else
        flash[:alert] = 'Payment confirmation failed.'
      end
    else
      # Proceed without payment

      flash[:notice] = 'Order confirmed without payment.'
    end

    redirect_to order_path(@order)
  end

  private

  def payment_successful?(order)
    if order.payment_intent_id.present?
      payment_intent = Stripe::PaymentIntent.retrieve(order.payment_intent_id)
      return payment_intent.status == 'succeeded'
    end
    false
  rescue Stripe::StripeError => e
    Rails.logger.error("Stripe error while checking payment: #{e.message}")
    false
  end
end
