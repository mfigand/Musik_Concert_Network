class ConcertsController < ApplicationController

  def index
    @concert = Concert.get_today_concert
    @concertMonth = Concert.get_month_concert

  end

  def new
    @concert = Concert.new
  end

  def create
    @concert = Concert.new concert_params
    if @concert.save
      flash[:notice] = "Concert created succesfully"
      redirect_to action: :index, concert_id: @concert.id
    else
      flash[:alert] = "ALERT Concert not created"
      render 'new'
    end
  end

    def show
      @concert = Concert.find_by(id: params[:id])
      @comments_concert = @concert.comments
      @comment_new = Comment.new
    end

    def show_search
      @search_result = Concert.search_by_price(params[:search])
    end

    def top_commented
      @top_commented = Concert.get_most_commented

    end

  private

  def concert_params
   params.require(:concert).permit(:artist, :venue, :city, :date, :price, :description)
  end



end
