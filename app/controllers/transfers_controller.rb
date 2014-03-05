class TransfersController < ApplicationController

  before_action :signed_in_user, only: [:create, :destroy]

  def create
    @tranfer = Transfer.new(transfer_params)
    if transfer_params[:sender_id] == current_user.id && @tranfer.save
      flash[:success] = 'hhhhh'
      redirect_to root_path
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
    params.require(:transfer).permit(:sender_id, :recipient_id, :amount, :message)
  end
end
