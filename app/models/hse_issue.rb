# app/models/hse_issue.rb
class HseIssue < Issue
    def status_color
      case status.name.downcase
      when 'activo' then '#28a745'
      when 'retirado' then '#dc3545'
      else '#6c757d'
      end
    end
    
    def days_until_expiry(date_field)
      return nil unless self[date_field]
      (self[date_field].to_date - Date.today).to_i
    end
   
    def pending_document_count
      count = 0
      count += 1 if custom_field_value(11).blank? # EMO
      count += 1 if custom_field_value(13).blank? # Evaluación
      count += 1 if custom_field_value(23).blank? # Dotación
      count
    end
   end