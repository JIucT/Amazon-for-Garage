module ApplicationHelper
  def cart_status
    if cookies[:ordered_items].nil? || cookies[:ordered_items].count(',') == 0
      'EMPTY' 
    else
      cookies[:ordered_items].count(',')
    end
  end
end
