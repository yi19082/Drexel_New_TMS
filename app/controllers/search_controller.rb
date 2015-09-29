class SearchController < ApplicationController
  def index
  	if params[:term]
  		term_id = Term.find_by(name: params[:term]['name']).id
  	else
  		term_id = Term.first.id
  	end
	@search = Course.where(term_id: term_id).search(params[:q])
	@courses = @search.result.order(id: :desc).page(params[:page]).per(50)

	@search.build_condition
	redirect_to :back, notice: "You're query did not yield any results" if @courses.empty?
  end
end
