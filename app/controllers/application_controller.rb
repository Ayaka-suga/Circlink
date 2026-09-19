class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_group

  helper_method :current_group

  protected  

  def configure_permitted_parameters 
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username]) 
    devise_parameter_sanitizer.permit(:account_update, keys: [:username]) 
  end

  private

  def set_current_group
    return unless user_signed_in?

    # groups.id を明示して純粋なサークルIDを取得
    user_group_ids = current_user.groups.pluck("groups.id")

    if session[:current_group_id].present?
      target_id = session[:current_group_id].to_i
      if user_group_ids.include?(target_id)
        @current_group = Group.find_by(id: target_id)
      end
    end

    # セッション値が無い、または不正な場合は所属する最初のサークルをセット
    if @current_group.nil? && user_group_ids.present?
      @current_group = Group.find_by(id: user_group_ids.first)
      session[:current_group_id] = @current_group&.id
    end
  end

  
  
end