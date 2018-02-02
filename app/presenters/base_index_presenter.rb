class BaseIndexPresenter
  def initialize(resources, timestamp, current_user)
    @resources = resources
    @timestamp = timestamp
    @current_user = current_user
  end

  def to_json
    hash = PaginationPresenter.new(resources, timestamp).to_json
    hash[resource_name] = render_resources #dodava key ex: 'experiences'
    hash
  end

  private

  attr_reader :resources, :timestamp, :current_user

  def ignored_attributes
    {}
  end

  def resource_name
    return unless (resource = resources.first)
    resource.class.to_s.pluralize.underscore
  end

  def render_resources
    @resources.map { |r| r.attributes.except(*ignored_attributes) }
  end
end