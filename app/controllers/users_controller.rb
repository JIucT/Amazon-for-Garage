class UsersController < ApplicationController
  before_action :authenticate_user!

  def change_billing_address
    current_user.billing_address.destroy unless current_user.billing_address.nil?
    current_user.billing_address_id = address_create
    unless current_user.save
      render "shared/something_went_wrong"
    end        
    flash[:change_settings_msg] = "Billing address successfully updated"
    redirect_to edit_user_registration_path
  end

  def change_shipping_address
    current_user.shipping_address.destroy  unless current_user.shipping_address.nil?
    current_user.shipping_address_id = address_create
    unless current_user.save
      render "shared/something_went_wrong"
    end        
    flash[:change_settings_msg] = "Shipping address successfully updated"
    redirect_to edit_user_registration_path
  end

  def change_email
    current_user.email = email_params[:email]
    unless current_user.save
      render "shared/something_went_wrong"
    end    
    flash[:change_settings_msg] = "Email successfully updated"
    redirect_to edit_user_registration_path
  end

  def change_password
    user = current_user
    Rails.logger.debug(password_params)
    if user.update_with_password(password_params)
      sign_in user, :bypass => true
      flash[:change_settings_msg] = "Password successfully updated"
      redirect_to edit_user_registration_path
    else
      render "shared/something_went_wrong"
    end
  end

private
  def password_params
    params.required(:password).permit(:password, :password_confirmation, :current_password)
  end

  def email_params
    params.require(:email).permit(:email)
  end

  def address_params
    params.require(:address).permit(:address1, :city, :country, :zip_code, :mobile_number)
  end

  def address_create
    new_addr = Address.new(address_params)
    unless new_addr.save
      render "shared/something_went_wrong"
    end
    return new_addr.id
  end
end
