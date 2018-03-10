class MoviesController < ApplicationController


  def show
    id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #/* March 8 HW2 part 1 and 2 */
    @all_ratings = Movie.all_ratings #the ratings are fetched from the Movie model

    @sortByDate
    @sortByTitle
    @ratingsSortEnabled
        puts params[:session]

    if params[:commit] == "Refresh"
      puts params[:session]
      puts "!!Need to sort according to ratings"
      @ratingsSortEnabled = true
    end
    
    
    #Combination of work for HW2 part 1 and 2, checks to see if 
    #parameters passed are either "title" or "date", sorts accordingly
    #if they are neither, then just sort according to checkboxes
    #could not get to sort with the check boxes and the date/title parameters. 
    #You can see that, the "refresh" button is unclickable,
    #thus can't be sorted that way
    @sortChoice = params[:sortChoice]
    
    if @sortChoice == 'title'
      @sortByDate = false
      @sortByTitle = true
      @movies = Movie.order(:title)
      
      #sort according to release date
    elsif @sortChoice == 'release_date'
    
        
        @movies = Movie.order(:release_date)
        

    else
        #Returns all movies if 
        ##it can not find ratings being checked off
        if params[:ratings] == nil
          puts "CRASH: no ratings found"
          @movies = Movie.all
        else
        
        @desiredRatings = params[:ratings]
        puts @desiredRatings
        
        @ratings = []
        @desiredRatings.each do |rating|
          @ratings << rating
        end
        puts @ratings
        
        @movies = Movie.where(:rating=>@ratings)
        end
        
    end
    

    #/* ---------------- */
  end
 
 


  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

      def movie_params
        params.require(:movie).permit(:title, :rating, :description, :release_date, :timestamps, :sortChoice)
    end

end
