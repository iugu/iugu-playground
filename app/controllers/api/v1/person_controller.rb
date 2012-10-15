class Api::V1::PersonController < Api::V1::BaseApiController

  def index
    limit = [ params[:limit].try(:to_i) || 100, 1000 ].min
    start = params[:start] || 0
    respond_with @current_account.people.limit(limit).offset(start)
  end

  def show
    respond_with @current_account.people.find(params[:id])
  end

  def create
    respond_with @current_account.people.create(build_params_for(Person)), location: nil
  end

  def update
    respond_with @current_account.people.update(params[:id], build_params_for(Person)), location: nil
  end

  def destroy
    respond_with @current_account.people.find(params[:id]).destroy
  end

end
