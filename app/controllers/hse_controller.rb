# app/controllers/hse_controller.rb
class HseController < ApplicationController
  before_action :require_admin
  before_action :find_projects, only: [:index]
  
  def index
    @query = IssueQuery.new(name: 'HSE')
    @query.filters = {
      'tracker_id' => { operator: '=', values: ['4'] }
    }
    
    if params[:search].present?
      @query.add_filter('subject', '~', [params[:search]])
    end
    
    if params[:project_id].present?
      @query.add_filter('project_id', '=', [params[:project_id]])
    end

    base_issues = @query.issues
    @issues = base_issues.map { |i| HseIssue.find(i.id) }
    @custom_fields = CustomField.where(tracker_id: 4)
    
    respond_to do |format|
      format.html
      format.json { render json: @issues }
      format.csv {
        send_data export_issues_to_csv(@issues),
          filename: "hse_#{Date.today}.csv",
          type: 'text/csv'
      }
    end
  end

  private
  
  def find_projects
    @projects = Project.active.has_module(:issue_tracking)
  end

  def export_issues_to_csv(issues)
    require 'csv'
    CSV.generate do |csv|
      headers = ['ID', 'Colaborador', 'Estado', 'Regional', 'Empresa', 
                'EMO', 'Evaluación', 'Dotación', 'Próximos Vencimientos']
      csv << headers
      
      issues.each do |issue|
        row = [
          issue.id,
          issue.subject,
          issue.status.name,
          issue.custom_field_value(7),
          issue.custom_field_value(8),
          issue.custom_field_value(11).present? ? 'Si' : 'No',
          issue.custom_field_value(13).present? ? 'Si' : 'No',
          issue.custom_field_value(23).present? ? 'Si' : 'No',
          next_expiry_dates_text(issue)
        ]
        csv << row
      end
    end
  end

  def next_expiry_dates_text(issue)
    dates = []
    dates << "EMO: #{issue.custom_field_value(17)}" if issue.custom_field_value(17).present?
    dates << "Reind.: #{issue.custom_field_value(15)}" if issue.custom_field_value(15).present?
    dates.join(' | ')
  end
end