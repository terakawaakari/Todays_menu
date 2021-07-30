class HomesController < ApplicationController

  before_action :set_q

  def top
  end

  def roulette
    @dish1 = Roulette.all.sample.dish
    @dish2 = Roulette.where.not(dish: @dish1).sample.dish
    @dish3 = Roulette.where.not(dish: @dish1).where.not(dish: @dish2).sample.dish
    @dish4 = Roulette.where.not(dish: @dish1).where.not(dish: @dish2).where.not(dish: @dish3).sample.dish

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
  end

  private

  def set_q
    @q = Recipe.where(is_open: true).ransack(params[:q])
  end

end
