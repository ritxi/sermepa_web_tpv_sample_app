class PaymentsController < ApplicationController
  skip_before_filter :verify_authenticity_token

  def new
        transaction = Transaction.new(amount: 10)
        sermepa_request = SermepaWebTpv::Request.new(transaction, "Transaction description")
        sermepa_request.transact {|t| t.save }
        render json: { payment_options: sermepa_request.options, url: sermepa_request.bank_url  }
    # Submit a form with given options to the url
  end

  def success
    flash[:notice] = "Payment done successfuly!"
    redirect_to roo_path
  end

  def failure
    flash[:failure] = "Payment failed, try again later."
    redirect_to roo_path
  end

  def validate
    remote_response = SermepaWebTpv::Response.new(params)
    if remote_response.valid? && remote_response.success?
      # mark your transaction as finished
      logger.info "Transacction success! #{params[:Ds_Order]}"
    end
  end
end