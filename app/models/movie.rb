class Movie < ActiveRecord::Base
    
    #/* March 9 HW2 part 2 */
    #Controller fetches the ratins from the model
    def self.all_ratings
        @all_ratings = ['G','PG','PG-13','R']
    end
    #/*                 */ 
end
