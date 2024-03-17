class HomeController < ApplicationController
  def index
    @investments = Investment.all
      
    @investments.each_with_index do |investment, index|
      investment.update(image_url: "nafaka#{index + 2}.jpg")
    end
  end
end
