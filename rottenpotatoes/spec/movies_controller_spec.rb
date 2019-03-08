require 'rails_helper'

RSpec.describe MoviesController, type: :controller do
    describe 'find movies with same director' do
        
        it 'should call the model method to find movies with same director' do
            Movie.should_receive(:find_all_by_director).with('1')
            get :bydirector, {:id => '1'}
        end
        
        it 'should render the bydirector template when the movie has director info' do
            Movie.stub(:find_all_by_director).and_return([false,nil,nil])
            get :bydirector, {:id => '1'}
            response.should render_template("bydirector")
        end
        
        it 'should display all the movies directed by the same director as selected' do
            movie = double('Movie', :title => 'Aladdin')
            movies = [double('Movie'),double('Movie')]
            Movie.stub(:find_all_by_director).and_return([false,movie,movies])
            get :bydirector, {:id => '2'}
        end
        
        
        it 'should display the index page when the movie has no director info' do
            movie = double('Movie', :title => 'Amelie')
            Movie.stub(:find_all_by_director).and_return([true,movie,[]])
            get :bydirector, {:id => '3'}
            response.should redirect_to movies_path
            flash[:notice].should eq("'#{movie.title}' has no director info")
        end
        
         it 'should display the error message' do
            movie = double('Movie', :title => 'Amelie')
            Movie.stub(:find_all_by_director).and_return([true,movie,[]])
            get :bydirector, {:id => '3'}
            flash[:notice].should eq("'#{movie.title}' has no director info")
        end
       
 
        
    end
end