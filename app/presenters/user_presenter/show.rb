module UserPresenter
  class Show < BaseShowPresenter
    private

    def ignored_attributes
      %w[status]
    end
  end
end
