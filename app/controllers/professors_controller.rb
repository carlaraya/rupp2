class ProfessorsController < ApplicationController
  before_action :set_professor, only: [:show, :edit, :update, :destroy]
  def index
      if not params[:q].blank?
	  @professors = Professor.search(params[:q])
      else
	  @professors = Professor.all
      end
      if not params[:order].blank?
	if params[:order] == "rating"
	    order = "overall"  
	else
	    order = "last_name"
	end
      end

      if not params[:sort].blank?
	sort = params[:sort]
      else
	  sort = "DESC"
      end
	  @professors = @professors.order_by(order + " " + sort)
  end

  def show
    
  end

  def edit

  end

  def new
      @professor = Professor.new
  end

  def create
      @professor = Professor.new(professor_params)
      if @professor.save
	  redirect_to @professor, notice: "Professor has been added"
      else
	  render :new
      end
  end

  def update
      if @professor.update(professor_params)
	  redirect_to @professor, notice: "Professor updated"
      else
	  render :edit
      end
  end

  def destroy
      @professor.destroy
      redirect_to professors_path, notice: "Professor deleted"
  end
  
  private 
  def set_professor
      @professor = Professor.find(params[:id])
  end

  def professor_params
      params.require(:professor).permit(:first_name, :last_name)
  end
end
