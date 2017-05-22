class JobsController < ApplicationController
  before_action :set_company, except: [:index]
  before_action :set_job, only: [:show, :edit, :update, :destroy]
  def index
    if params[:location]
      @jobs = Job.where(city: params[:location])
    elsif params[:sort]
      @jobs = Job.sorted(params[:sort])
    else
      @jobs = Job.all
    end
  end

  def new
    @job = Job.new()
  end

  def create
    @job = @company.jobs.new(job_params)
    if @job.save
      flash[:success] = "You created #{@job.title} at #{@company.name}"
      redirect_to company_job_path(@company, @job)
    else
      render :new
    end
  end

  def show
    @comment = Comment.new
  end

  def edit
  end

  def update
    @job.update(job_params)
    if @job.save
      flash[:success] = "#{@job.title} updated!"
      redirect_to company_job_path(@company, @job)
    else
      render :edit
    end
  end

  def destroy
    @job.destroy
    flash[:success] = "Job ID #{@job.id} was successfully deleted!"
    redirect_to company_path(@company)
  end

  private

   def set_company
     @company = Company.find(params[:company_id])
   end

   def set_job
     @job = Job.find(params[:id])
   end

   def job_params
     params.require(:job).permit(:title, :description, :level_of_interest, :city, :category_id)
   end
end
