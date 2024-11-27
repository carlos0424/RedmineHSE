Rails.application.routes.draw do
    get 'hse', to: 'hse#index'
    get 'hse/export', to: 'hse#export'
   end