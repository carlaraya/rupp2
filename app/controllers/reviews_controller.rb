class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_professor, only: [:index, :set_review, :create]

  def index
    @reviews = @professor.reviews
  end
  def show

  end

  def new
      @review = Review.new
  end

  def edit

  end

  def create
      @review = Review.new(review_params)
      @review.professor = @professor
      
      if @review.save
	redirect_to @professor, notice: "Review was successfully submitted"
      else
	render :new
      end
  end

  def update
    if @review.update(review_params)
	redirect_to @professor, notice: "Review was successfully updated"
    else
	render :edit
    end
  end

  def destroy
    @review.destroy
    redirect_to @professor, notice: "Review deleted"
  end

  private
  def set_review
      @review = professor.reviews.find(params[:id])
  end

  def set_professor
      @professor = Professor.find(params[:professor_id])
  end

  def review_params
      params.require(:review).permit(:class_taken, :year, :helpfulness, :pedagogy, :easiness, :comment)
  end
end
