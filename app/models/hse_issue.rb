class HseIssue < Issue
    def days_until_expiry(date_field)
      return nil unless self[date_field]
      (self[date_field].to_date - Date.today).to_i
    end
    
    def status_color
      case status.name.downcase
      when 'activo' then 'green'
      when 'retirado' then 'red'
      else 'gray'
      end
    end
  end
  