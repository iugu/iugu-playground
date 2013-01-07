class Api::V1::PersonController < Api::V1::BaseApiController

  def index
    options = {}
    options[:query] = params[:query]
    options[:limit] = [ params[:limit].try(:to_i) || 100, 1000 ].min
    options[:start] = params[:start] || 0
    options[:account_id] = @current_account.id.to_s
    options[:sortBy] = params[:sortBy]
    options[:created_at_from] = ""
    options[:created_at_to] = ""
    options[:created_at_from] = params[:created_at_from].to_date.to_s unless params[:created_at_from].blank?
    options[:created_at_to] = params[:created_at_to].to_date.to_s unless params[:created_at_to].blank?
    options[:age_filter] = params[:age_filter] unless params[:age_filter].blank?
    options[:gender_filter] = params[:gender_filter] unless params[:gender_filter].blank?

    @people = Person.search(options)

    @totalItems = @people.total

    mapped = []
    @people.each do |r|
      mapped.push OpenStruct.new(r.to_hash)
    end

    mapped_facets = []
    mapped_facets = OpenStruct.new(@people.facets)

    @facets = mapped_facets
    @items = mapped
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
