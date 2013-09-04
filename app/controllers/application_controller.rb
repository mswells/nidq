require "urbanairship"

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  Urbanairship.application_key = 'HHyASKcvQfeZslB_KDSRdg'
  Urbanairship.application_secret = 'M9H-DwexRD6e1We2Aoa-Og'
  Urbanairship.master_secret = 'TepIM_3_QB2dcV9d7WRIFQ'
  Urbanairship.logger = Rails.logger
  Urbanairship.request_timeout = 5 # default
  
end
