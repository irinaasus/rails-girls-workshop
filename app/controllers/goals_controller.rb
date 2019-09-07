class GoalsController < ApplicationController
  def index
    @goals = filtered_goals.order('complete DESC, due_date, priority DESC, title')
  end

  def new
    @goal = Goal.new
  end

  def create
    @goal = Goal.new(goal_params)
    if @goal.save
      flash[:success] = 'Your goal has been successfully created'
      redirect_to goals_path
    else
      flash.now[:error] = 'Please fill in all necessary fields.'
      render 'new'
    end
  end

  def show
    @goal = Goal.find_by(id: params[:id])
  end

  def edit
    @goal = Goal.find_by(id: params[:id])
  end

  def update
    @goal = Goal.find_by(id: params[:id])
    if @goal.update_attributes(goal_params)
      flash[:success] = 'Your goal has been successfully updated'
      if @goal.complete?
        redirect_to goals_path(filter: 'completed')
      else
        redirect_to goals_path
      end
    else
      flash.now[:error] = 'Please fill in all necessary fields.'
      render 'edit'
    end
  end

  private

  def filtered_goals
    if params[:filter] == 'completed'
      Goal.completed
    elsif params[:filter] == 'incomplete'
      Goal.incomplete
    else
      Goal.all
    end
  end

  def goal_params
      params.require(:goal).permit(:title, :description, :priority, :due_date, :complete)
  end
end
