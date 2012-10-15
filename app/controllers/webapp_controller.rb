class WebappController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]

  def entry_point
    render :layout => false
  end

  def index
    render 'webapp/welcome' unless current_user
  end
end
