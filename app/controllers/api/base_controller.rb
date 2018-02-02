class Api::BaseController < ApplicationController
  protect_from_forgery with: :null_session
  before_action :doorkeeper_authorize! unless Rails.env.test?
  before_action :set_current_user unless Rails.env.test?
  before_action :set_resource, only: [:destroy, :show, :update]
  respond_to :json

# POST /api/{plural_resource_name}
  def create
    set_resource(resource_class.new(resource_params))

    if get_resource.save
      render_create
    else
      render json: { errors: get_resource.errors }, status: :unprocessable_entity
    end
  end

# DELETE /api/{plural_resource_name}/1
  def destroy
    get_resource.destroy
    head :no_content
  end

# GET /api/{plural_resource_name}
  def index
    plural_resource_name = "@#{resource_name.pluralize}"
    resources = resource_class.where(query_params)
                  .page(page_params[:page])
                  .per(page_params[:page_size])

    instance_variable_set(plural_resource_name, resources)
    respond_with instance_variable_get(plural_resource_name)
  end

# GET /api/{plural_resource_name}/1
  def show
    respond_with get_resource
  end

# PATCH/PUT /api/{plural_resource_name}/1
  def update
    if get_resource.update(resource_params)
      render_update
    else
      render json: { errors: get_resource.errors }, status: :unprocessable_entity
    end
  end

  private

# Returns the resource from the created instance variable
# @return [Object]
  def get_resource
    instance_variable_get("@#{resource_name}")
  end

# Returns the allowed parameters for searching
# Override this method in each API controller
# to permit additional parameters to search on
# @return [Hash]
  def query_params
    {}
  end

# Returns the allowed parameters for pagination
# @return [Hash]
  def page_params
    params.permit(:page, :page_size)
  end

# The resource class based on the controller
# @return [Class]
  def resource_class
    @resource_class ||= resource_name.classify.constantize
  end

# The singular name for the resource class based on the controller
# @return [String]
  def resource_name
    @resource_name ||= self.controller_name.singularize
  end

# Only allow a trusted parameter "white list" through.
# If a single resource is loaded for #create or #update,
# then the controller for the resource must implement
# the method "#{resource_name}_params" to limit permitted
# parameters for the individual model.
  def resource_params
    @resource_params ||= self.send("#{resource_name}_params")
  end

# Use callbacks to share common setup or constraints between actions.
  def set_resource(resource = nil)
    resource ||= resource_class.find(params[:id])
    instance_variable_set("@#{resource_name}", resource)
  end

  def render_update
    render json: resource_update_presenter.new(*update_presenter_args).to_json
  end

  def resource_update_presenter
    resource_show_presenter
  end

  def update_presenter_args
    show_presenter_args
  end

  def render_create
    render json:
             resource_create_presenter
               .new(*create_presenter_args).to_json,
           status: :created
  end

  def resource_create_presenter
    resource_show_presenter
  end

  def resource_show_presenter
    "#{presenter_module_name}::Show".classify.constantize
  end

  def presenter_module_name
    "#{resource_name}_presenter"
  end

  def create_presenter_args
    show_presenter_args
  end

  def show_presenter_args
    [get_resource, get_resource]
  end

  def set_current_user
    token = request.headers['Authorization'].split(' ').last
    @current_user = User.find(Doorkeeper::AccessToken.find_by_token(token).resource_owner_id) if token
  end
end