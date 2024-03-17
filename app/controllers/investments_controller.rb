class InvestmentsController < ApplicationController

  def index
    @investments = Investment.all

    @investments.each_with_index do |investment, index|
      investment.update(image_url: "nafaka#{index + 2}.jpg")
    end
  end

  def show
    @investment = Investment.find(params[:id])
  end

  def invest
    investment = Investment.find(params[:id])
    current_user.investments << investment
    redirect_to investments_path, notice: 'Investment successful!'
  end

end
