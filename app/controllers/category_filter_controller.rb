class CategoryFilterController < ApplicationController
    skip_before_action :verify_authenticity_token

    #Function display all category filters
    def index
      categoryfilter=CategoryFilter.all
      render json:categoryfilter
    end
    #Adding a new category filter
    def create
      categoryfilter=CategoryFilter.new(categoryfilter_params)
      if categoryfilter.save then
        render json:{status:"SUCCESS",message:"Create category filter",data:categoryfilter}
      else
        render json:{status:"ERROR",message:"Category filter not create",data:categoryfilter.errors}
      end
    end

    #Function outputs category filter by id
    def show
      categoryfilter=CategoryFilter.find(params[:id])
      render json:categoryfilter
    end

    #Function update category filter attributes
    def update
     categoryfilter=CategoryFilter.find(params[:id])
     if categoryfilter.update_attributes(categoryfilter_params) then
        render json:{status:"SUCCESS",message:"Update category filter",data:categoryfilter}
     else
        render json:{status:"ERROR",message:"Category filter not update",data:categoryfilter.errors}
     end
    end

    private
    def categoryfilter_params
      params.permit(:category_id,:filter_id,:item_id,:value)
    end
  end
