class RecommendationsController < ApplicationController
  before_action :current_user_must_be_recommendation_user, :only => [:edit, :update, :destroy]

  def current_user_must_be_recommendation_user
    recommendation = Recommendation.find(params[:id])

    unless current_user == recommendation.user
      redirect_to :back, :alert => "You are not authorized for that."
    end
  end

  def index
    @recommendations = Recommendation.all

    render("recommendations/index.html.erb")
  end

  def show
    @recommendation = Recommendation.find(params[:id])

    render("recommendations/show.html.erb")
  end

  def new
    @recommendation = Recommendation.new

    render("recommendations/new.html.erb")
  end

  def create
    @recommendation = Recommendation.new

    @recommendation.recommendation = params[:recommendation]
    @recommendation.category_id = params[:category_id]
    @recommendation.country_id = params[:country_id]
    @recommendation.city_id = params[:city_id]
    @recommendation.address = params[:address]
    @recommendation.month_id = params[:month_id]
    @recommendation.year_id = params[:year_id]
    @recommendation.trip_id = params[:trip_id]
    @recommendation.visited_with = params[:visited_with]
    @recommendation.rating_id = params[:rating_id]
    @recommendation.notes = params[:notes]
    @recommendation.photo = params[:photo]
    @recommendation.user_id = params[:user_id]

    save_status = @recommendation.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/recommendations/new", "/create_recommendation"
        redirect_to("/recommendations")
      else
        redirect_back(:fallback_location => "/", :notice => "Recommendation created successfully.")
      end
    else
      render("recommendations/new.html.erb")
    end
  end

  def edit
    @recommendation = Recommendation.find(params[:id])

    render("recommendations/edit.html.erb")
  end

  def update
    @recommendation = Recommendation.find(params[:id])

    @recommendation.recommendation = params[:recommendation]
    @recommendation.category_id = params[:category_id]
    @recommendation.country_id = params[:country_id]
    @recommendation.city_id = params[:city_id]
    @recommendation.address = params[:address]
    @recommendation.month_id = params[:month_id]
    @recommendation.year_id = params[:year_id]
    @recommendation.trip_id = params[:trip_id]
    @recommendation.visited_with = params[:visited_with]
    @recommendation.rating_id = params[:rating_id]
    @recommendation.notes = params[:notes]
    @recommendation.photo = params[:photo]
    @recommendation.user_id = params[:user_id]

    save_status = @recommendation.save

    if save_status == true
      referer = URI(request.referer).path

      case referer
      when "/recommendations/#{@recommendation.id}/edit", "/update_recommendation"
        redirect_to("/recommendations/#{@recommendation.id}", :notice => "Recommendation updated successfully.")
      else
        redirect_back(:fallback_location => "/", :notice => "Recommendation updated successfully.")
      end
    else
      render("recommendations/edit.html.erb")
    end
  end

  def destroy
    @recommendation = Recommendation.find(params[:id])

    @recommendation.destroy

    if URI(request.referer).path == "/recommendations/#{@recommendation.id}"
      redirect_to("/", :notice => "Recommendation deleted.")
    else
      redirect_back(:fallback_location => "/", :notice => "Recommendation deleted.")
    end
  end
end
