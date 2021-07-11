class HomesController < ApplicationController

  def top
  end

  def roulette
    @label1 = params[:label1]
    @label2 = params[:label2]
    @label3 = params[:label3]
    @label4 = params[:label4]
  end

end
