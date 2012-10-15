class WebappController < ApplicationController
  def entry_point
    render :layout => false
  end
end
