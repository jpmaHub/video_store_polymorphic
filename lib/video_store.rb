class VideoStoreFactory
  def create(type , days_rented)
    case type
    when :regular
      RegularMovie.new(days_rented: days_rented)
    when :children
      ChildrenMovie.new(days_rented: days_rented)
    when :new_release
      NewReleaseMovie.new(days_rented: days_rented)
    end
  end

  def create_movie(name)
    Movie.new(movie_name: name)
  end 

end
