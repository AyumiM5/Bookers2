class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: [:top, :about]
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_search
  
  def set_search
    @q = Book.ransack(params[:q])
    @books = @q.result(distinct: true)
  end
  
  protected
  
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end
  
  def after_sign_in_path_for(resource)
    user_path(resource)
  end
  
  def after_sign_o_path_for(resource)
    root(resource)
  end
  
end
