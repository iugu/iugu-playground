class Api::V1::PersonController < Api::V1::BaseApiController

  def index
    respond_with @current_account.people
  end

  def show
    respond_with @current_account.people.find(params[:id])
  end

  def create
    respond_with @current_account.people.create(build_params_for(Person))
  end

  def update
    respond_with @current_account.people.update(params[:id], build_params_for(Person))
  end

  def destroy
    respond_with @current_account.people.find(params[:id]).destroy
  end

end
