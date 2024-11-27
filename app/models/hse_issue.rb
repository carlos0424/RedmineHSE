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
   end