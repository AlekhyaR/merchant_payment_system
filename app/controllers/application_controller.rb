class ApplicationController < ActionController::Base
  respond_to :html, :json
  
  include ApplicationHelper
end
