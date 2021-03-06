module ApplicationHelper
  def average_ratings(ratings_array)
    average_rating = ratings_array.reduce(0) do |sum, rating|
      sum + rating.score
    end
    if ratings_array.length > 0
         average_rating = average_rating / ratings_array.length
      else
        0
    end
  end
end
