class Product < ApplicationRecord
 has_many :reviews

  def review_average
    # self.reviews.average(:rate).round
    reviews.average(:rate).round
  end

end
