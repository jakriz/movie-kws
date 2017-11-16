class KeywordsController < ApplicationController

  def index
    respond_to do |format|
      format.json do
        render json: Keyword.pluck(:word)
      end
    end
  end

  def autocomplete
    respond_to do |format|
      format.json do
        render json: Keyword.autocomplete(params[:q])
      end
    end
  end

  def show
    @keyword = Keyword.find_by(word: params[:id])
    @amounts = @keyword.amounts_per_year

    respond_to do |format|
      format.json do
        render json: {
          word: @keyword.word,
          data: @amounts
        }
      end
    end
  end

  def show_year
    @movies = Keyword.find_by(word: params[:id]).movies_for_year(params[:year]).map do |movie|
      {
        title: movie.title,
        amount: movie.gross_amount_adjusted
      }
    end

    respond_to do |format|
      format.json do
        render json: @movies
      end
    end
  end

end
