class ExchangeController < ApplicationController
  before_action :authenticate_user!
  def new
    @exchange = Exchange.new
  end

  def create
    @exchange = Exchange.new(exchange_params)
    if @exchange.save
      redirect_to exchange_path, notice: "已成功兌換，您的兌換序號為"
    else
      render :new, notice: "您已於#{current_user.exchange.first.created_at}兌換過"
    end
  end

  private
  def exchange_params
    params.require(:exchange).permit(:company_name, :tax_id, :tel)
  end
end
