class ItemController < ApplicationController
  skip_before_action :verify_authenticity_token

  #Function display all users
  def index
    item=Item.all.paginate(page: params[:page],per_page:5)
    render json:item
  end

  #Adding a new Item
  def create
    item=Item.new(item_params)
    if item.save then
      render json:{status:"SUCCESS",message:"Create item",data:item}
    else
      render json:{status:"ERROR",message:"User not create",data:item.errors}
    end
  end

  #Function outputs items by id
  def show
    item=Item.find(params[:id])
    render json:item
  end

  #Function update item attributes
  def update
   item=Item.find(params[:id])
   if item.update_attributes(item_params) then
      render json:{status:"SUCCESS",message:"Update item",data:item}
   else
      render json:{status:"ERROR",message:"Item not update",data:item.errors}
   end
  end

  #The function displays all elements in a specific city
  def items_in_city
    items=Item.joins(:user).where(users:{city_id: params[:city_id]}).paginate(page:params[:page],per_page:5)
    render json:items
  end

  #Filter items by name
  def filter_by_name
     items=Item.where("name LIKE ?","%"+params[:name]+"%").paginate(page:params[:page],per_page:5)
     render json:items
  end

  #Filter items by category
  def filter_by_category
     items=Item.joins(:category_filters).where(category_filters:{category_id:params[:category_id]}).group("items.id").paginate(page:params[:page],per_page:5)
     render json:items
  end

  #Filter items by category option
  def filter_by_category_option
     items=Item.joins(:category_filters).where(category_filters:{category_id:params[:category_id],filter_id:params[:filter_id],value:params[:value]},).paginate(page:params[:page],per_page:5)
     render json:items
  end

  #Filter by non booked date
  def filter_by_booked
    #items=Item.joins(:bookings).where.not(bookings:{start:(params[:start]..params[:end]),end:(params[:start]..params[:end]),status:'End'}).union(Item.left_joins(:bookings).where(bookings:{id:nil}))#.paginate(page:params[:page],per_page:5)
    itemsID=Item.joins(:bookings).select("items.id").where(bookings:{start:(params[:start]..params[:end]),end:(params[:start]..params[:end])})
    items=Item.where.not(id:itemsID).paginate(page:params[:page],per_page:5)
    render json:items
  end

  #Filter by price range
  def filter_by_price_range
    items=Item.joins(:category_filters).where(category_filters:{category_id:params[:category_id]},items:{price:(params[:min]..params[:max])}).group("items.id").paginate(page:params[:page],per_page:5)
    render json:items
  end

  private
  def item_params
    params.permit(:name,:price,:user_id)
  end
end
