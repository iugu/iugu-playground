class Api::V1::BaseApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_for_valid_request!, :set_locale

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found  
  
  respond_to :json, :xml

  layout false

  def check_for_valid_request!
    authenticate_with_http_basic do |username|
      @current_account = Account.find_by_api_token( username )
    end
    @current_account = Account.find_by_api_token( params[:api_token] ) if params[:api_token]

    render 'api/v1/401', :status => :unauthorized unless @current_account
  end

  def not_found
    render 'api/v1/404', :status => :not_found
  end

  private

  def set_locale
    I18n.locale = params[:hl] || "en"
  end
end