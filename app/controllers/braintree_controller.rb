class BraintreeController < ApplicationController
  def new
  	@client_token = Braintree::ClientToken.generate
    @reservation = Reservation.find(params[:reservation_id])
    @payment = Payment.new
  end

  def checkout
  	nonce_from_the_client = params[:checkout_form][:payment_method_nonce]
    @reservation = Reservation.find(params[:checkout_form][:reservation_id])
    @payment = Payment.new(payment_params)
    
  	result = Braintree::Transaction.sale(
  		# :amount => "10.00", # this is currently hardcoded
  		:amount => params[:checkout_form][:amount],
      :payment_method_nonce => nonce_from_the_client,
  		:options => {
  			:submit_for_settlement => true
  		}
  	)

  	if result.success?
      @payment.save
  		redirect_to @reservation, :flash => { :success => "Transaction successful!" }
  	else
  		redirect_to @reservation, :flash => { :error => "Transaction failed. Please try again." }
  	end
  end

  private

  def payment_params
    params.require(:checkout_form).permit(:reservation_id, :amount)
  end
end
