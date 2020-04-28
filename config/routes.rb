Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #City
  resources :city

  #Users
  resources :user

  #Category
  resources :category

  #Filters
  resources :filter

  #Items
  resources :item
  get 'items_in/city'=>'item#items_in_city'
  get 'filter_by/name'=>'item#filter_by_name'
  get 'filter_by/category'=>'item#filter_by_category'
  get 'filter_by/category/option'=>'item#filter_by_category_option'
  get 'filter_by/booked'=>'item#filter_by_booked'
  get 'filter_by/price_range'=>'item#filter_by_price_range'
  #Categoryfilter
  resources :category_filter

  #Booking
  resources :booking

  #Reviews
  get 'review'=>'review#show'
  get 'user/item/reviews'=>'review#showAllRewiewsToAllItems'

  #Review for items
  post 'item/create_review'=>'rewiev_item#create'
  get 'review_item'=>'rewiev_item#show'

  #Review for users
  post 'user/create_review'=>'rewiev_user#create'
  get 'review_user'=>'rewiev_user#show'
end
