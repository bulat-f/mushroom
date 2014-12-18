class TransfersController < ApplicationController

  before_action :signed_in_user, only: [:create, :destroy]

  def new
    @transfer = Transfer.new(sender_id: current_user.id)
  end

  def create
    @transfer = current_user.remittances.build(transfer_params)
    @recipient = User.find_by_id(@transfer.recipient_id)
    current_user.wallet = 0 unless current_user.wallet
    @recipient.wallet = 0 unless @recipient.wallet
    current_user.wallet -= @transfer.amount
    @recipient.wallet += @transfer.amount
    if @transfer.save
      current_user.save
      current_user.update_attribute(:wallet, current_user.wallet)
      @recipient.update_attribute(:wallet, @recipient.wallet)
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    else
      flash[:warning] = 'hhhh'
      redirect_to root_path
    end
  end

  def destroy
    Transfer.find_by(params[:id]).destroy!
    redirect_to finance_user_path(current_user)
  end

  private

  def transfer_params
    params.require(:transfer).permit(:recipient_id, :amount, :message)
  end
end
