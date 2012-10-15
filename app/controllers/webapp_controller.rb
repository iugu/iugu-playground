class WebappController < ApplicationController
  def entry_point
    if current_user
      render :layout => false
    else
      redirect_to '/'
    end
  end
end
