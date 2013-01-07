class Api::V1::BaseApiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :check_for_valid_request!, :set_locale

  rescue_from ActiveRecord::RecordNotFound, :with => :not_found  
  
  respond_to :json, :xml

  layout false

  def check_for_valid_request!
    authenticate_with_http_basic { |token| @token = token }
    if @token = ApiToken.find_by_token(params[:api_token] || @token)
      case 
      when @token.tokenable.class == User
        @current_user = @token.tokenable
        if params[:account_id] 
          @current_account = @current_user.account_users.find_by_account_id(params[:account_id]).account
        else
          @current_account = @current_user.account_users.first.account
        end
      when @token.tokenable.class == Account
        @current_account = @token.tokenable
      end
      return unauthorized unless @current_account 
    else
      unauthorized
    end
  end

  def build_params_for(model, options = {})
    _params = Hash.new
    model.column_names.each { |attr| _params.merge!({ attr => params[attr] }) if params[attr] }
    options[:nested_attributes].each { |m| _params.merge!({"#{m}_attributes" => params[m]}) if params[m] } if options[:nested_attributes]
    _params
  end

  def not_found
    render 'api/v1/404', :status => :not_found
  end

  def unauthorized
    render 'api/v1/401', :status => :unauthorized
  end

  private

  def set_locale
    I18n.locale = params[:hl] || "en"
  end
end
