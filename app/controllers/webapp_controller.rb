class WebappController < ApplicationController
  before_filter :authenticate_user!

  def entry_point
    render :layout => false
  end
end
