#frozen_string_literal: false

module News
  #Provides access to author data
  class Category
    def initialize(category_data)
      @category = category_data
    end

    def status
      @category['status']
    end

    def source
      @category['source']
    end

    def sortBy
      @category['sortBy']
    end

    def articles
      @articles ||= Articles.new(@category['articles'])
    end

  end
end
