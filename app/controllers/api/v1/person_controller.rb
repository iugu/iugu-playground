class Api::V1::PersonController < Api::V1::BaseApiController

  def index
    respond_with @current_account.persons
  end

  def show
    respond_with @current_account.persons.find(params[:id])
  end

  def create
    respond_with @current_account.persons.create(params[:person])
  end

  def update
    respond_with @current_account.persons.update(params[:id], params[:person])
  end

  def destroy
    respond_with @current_account.persons.find(params[:id]).destroy
  end

end
