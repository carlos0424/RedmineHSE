# app/helpers/hse_helper.rb
module HseHelper
    def format_days_remaining(days)
      return '-' unless days
      if days < 0
        content_tag(:span, "Vencido hace #{days.abs} días", class: 'text-danger')
      else
        content_tag(:span, "#{days} días restantes", class: 'text-success')
      end
    end
   
    def pending_documents(issue)
      pending = []
      pending << 'EMO' if issue.custom_field_value(11).blank?
      pending << 'Evaluación Inducción' if issue.custom_field_value(13).blank?
      pending << 'Dotación' if issue.custom_field_value(23).blank?
      pending.any? ? content_tag(:span, pending.join(', '), class: 'text-danger') : content_tag(:span, 'Completo', class: 'text-success')
    end
   
    def next_expiry_dates(issue)
      dates = []
      dates << ["EMO", issue.custom_field_value(17)] if issue.custom_field_value(17).present?
      dates << ["Reind.", issue.custom_field_value(15)] if issue.custom_field_value(15).present?
      
      dates.map do |name, date|
        expiry = Date.parse(date) rescue nil
        next unless expiry
        days = (expiry - Date.today).to_i
        "#{name}: #{format_days_remaining(days)}"
      end.compact.join('<br>').html_safe
    end
   end