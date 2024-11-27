module HseHelper
    def format_days_remaining(days)
      return '-' unless days
      if days < 0
        content_tag(:span, "Vencido hace #{days.abs} días", class: 'text-danger')
      else
        content_tag(:span, "#{days} días restantes", class: 'text-success')
      end
    end
  end
  