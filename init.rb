require 'redmine'

Redmine::Plugin.register :redmine_hse do
  name 'Redmine HSE Plugin'
  author 'Carlos Arbelaez'
  description 'Plugin para gestión HSE de colaboradores'
  version '1.0.0'
  
  menu :top_menu, :hse, 
       { controller: 'hse', action: 'index' },
       caption: 'HSE',
       if: Proc.new { User.current.admin? }
end