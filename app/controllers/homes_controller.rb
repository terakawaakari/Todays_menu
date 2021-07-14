class HomesController < ApplicationController

  def top
  end

  def roulette
    if params[:label1].blank?
      @label1 = params[:h_label1]
    else
      @label1 = params[:label1]
    end

    if params[:label2].blank?
      @label2 = params[:h_label2]
    else
      @label2 = params[:label2]
    end

    if params[:label3].blank?
      @label3 = params[:h_label3]
    else
      @label3 = params[:label3]
    end

    if params[:label4].blank?
      @label4 = params[:h_label4]
    else
      @label4 = params[:label4]
    end

    # @label1 = params[:label1]
    # @label2 = params[:label2]
    # @label3 = params[:label3]
    # @label4 = params[:label4]
  end

end
