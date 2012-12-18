class Api::V1::PersonController < Api::V1::BaseApiController

  def index
    limit = [ params[:limit].try(:to_i) || 100, 1000 ].min
    start = params[:start] || 0
    @people = @current_account.people.order("id DESC").limit(limit).offset(start)
    @totalItems = @current_account.people.count
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

  def search
    limit = [ params[:limit].try(:to_i) || 100, 1000 ].min
    start = params[:start] || 0
    @people = @current_account.people.search params['query'], per_page: limit, from: start
    @totalItems = @people.total

    mapped = []
    @people.each do |r|
      mapped.push OpenStruct.new(r.to_hash)
    end

    @people = mapped
  end

  def undo
    @version = Version.with_item_keys("person", params[:id]).first
    @person = @current_account.people.find_by_id(params[:id])
 
    if @version.reify.try(:account_id) == @current_account.id || @person
      if @version.revert
        @person = @current_account.people.find_by_id(params[:id]) || @person
      else
        render 'api/v1/404', status: :not_found
      end
    end 
  end

end
