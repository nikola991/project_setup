class PaginationPresenter
  def initialize(resources, timestamp)
    @resources = resources
    @timestamp = timestamp
  end

  def to_json
    {
      'timestamp' => timestamp,
      'num_pages' => resources.total_pages,
      'current_page' => resources.current_page,
      'total_count' => resources.total_count
    }
  end

  private

  attr_reader :resources, :timestamp
end
