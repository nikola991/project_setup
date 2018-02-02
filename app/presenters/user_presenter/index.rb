module UserPresenter
  class Index < BaseIndexPresenter
    private

    def resource_name
      'users'
    end

    def ignored_attributes
      %w[status]
    end
  end
end