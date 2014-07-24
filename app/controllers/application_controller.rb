class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!	
  def index 
  end
  def add
    if params[:save]	
      @date = Date.strptime(params[:date],'%Y-%m-%d')
      @week_no = @date.strftime("%U").to_i
      @year = @date.year
      @weeklytask = Weeklytask.find_or_create_by( :user_id => current_user.id, :week_no => @week_no, :year => @year )
      @weeklytask.planned = params[:planned]
      @weeklytask.unplanned = params[:unplanned]
      @weeklytask.backlogs = params[:backlogs]
      @weeklytask.save
      @dailytask = Dailytask.new( { :weekly_task_id => @weeklytask.id , :date => params[:date] , :accomplishments => params[:accomplishments], :plans => params[:plans], :issues => params[:issues] })
      @dailytask.save 
    else
      t = Time.now
      @date = Date.strptime(t.strftime("%Y-%m-%d"),'%Y-%m-%d')
      @week_no = @date.strftime("%U").to_i
      @year = @date.year
      @weeklytask = Weeklytask.where( "user_id = ? and week_no = ? and year = ? ",current_user.id,@week_no,@year ).first
    end	
  end

  def update
    if params[:save]	
      @dailytask = Dailytask.find(params[:daily_task_id])
      @dailytask.plans = params[:plans]
      @dailytask.accomplishments = params[:accomplishments]
      @dailytask.issues = params[:issues]
      @dailytask.save
      @weeklytask = Weeklytask.find(@dailytask.weekly_task_id)
      @weeklytask.planned = params[:planned]
      @weeklytask.unplanned = params[:unplanned]
      @weeklytask.backlogs = params[:backlogs]
      @weeklytask.save
      redirect_to :controller=> 'application' , :action => 'view'
    else
      @dailytask = Dailytask.find(params[:daily_task_id])
      @weeklytask = Weeklytask.find(@dailytask.weekly_task_id)
    end
  end

  def view
  end

  def viewall
  end	

end
