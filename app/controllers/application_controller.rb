class ApplicationController < ActionController::Base

  # この記述がないとparameterが値を受け取ってくれない（protected以下の定義が反映されない）
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_user, :logged_in?

  # deviseの新規user登録後（root "books#home"）、リダイレクト先を変更する
  def after_sign_in_path_for(resource)
    user_path(resource)
  end


    protected

    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
      devise_parameter_sanitizer.permit(:sign_in, keys: [:name])
      devise_parameter_sanitizer.permit(:account_update, keys: [:introduction, :name, :user_image])
    end
  end
