class HseController < ApplicationController
  before_action :require_admin
  
  def index
    @issues = Issue.where(tracker_id: 4)
                   .includes(:status, :priority, :assigned_to)
                   .order(created_on: :desc)

    @custom_fields = CustomField.where(tracker_id: 4)
    
    respond_to do |format|
      format.html
      format.json { render json: @issues }
    end
  end
end