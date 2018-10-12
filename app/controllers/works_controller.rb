class WorksController < ApplicationController
  before_action :find_work, only: [:show, :edit, :update, :destroy]

  def index
    @works = Work.all
  end

  def show
    @vote = Vote.where(work_id: params[:id])

    if @work.nil?
      head :not_found
    end
  end

  def new
    @work = Work.new
  end

  def create
    filtered_work_params = work_params()
    @work = Work.new(filtered_work_params)

    is_successful_save = @work.save

    if is_successful_save
      flash[:success] = "Successfully created new work with title \"#{@work.title}\""
      redirect_to works_path
    elsif @work.title.empty?
      flash.now[:error] = "Missing title. Try again."
      render :new, status: :bad_request
    else
      flash.now[:error] = "Invalid work data. Unable to save."
      render :new, status: :bad_request
    end
  end

  def edit
  end

  def update
    if @work.update(work_params)
      redirect_to work_path(@work.id)
    else
      render :edit, status: :bad_request
    end
  end

  def destroy
    @work.destroy
    redirect_to works_path
  end

  private

  def work_params
    return params.require(:work).permit(
      :category,
      :title,
      :creator,
      :publication_year,
      :description
    )
  end

  def find_work
    @work = Work.find_by(id: params[:id])
  end
end
