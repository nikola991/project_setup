class BaseShowPresenter
  def initialize(resource, current_user)
    @resource = resource
    @current_user = current_user
  end

  def to_json
    @resource.attributes.except(*ignored_attributes)
  end

  def ignored_attributes
    []
  end

  private

  attr_reader :resource, :current_user
end
