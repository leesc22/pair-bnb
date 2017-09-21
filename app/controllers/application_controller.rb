class ApplicationController < ActionController::Base
  include Clearance::Controller
  protect_from_forgery with: :exception

	# def allowed?(action:, user:)
	# 	if user.customer?
	# 		if false # action ==
	# 			flash[:notice] = "Sorry. Access denied."
	# 			return redirect_back(fallback_location: root_path)
	# 		end
	# 	end
	# end

	private
	
	def customer_only
		unless current_user.customer?
			flash[:notice] = "Sorry. Access denied."
			return redirect_back(fallback_location: root_path)
		end
	end

	def admin_only
		unless current_user.admin?
			flash[:notice] = "Sorry. Access denied."
			return redirect_back(fallback_location: root_path)
		end
	end

	def moderator_and_admin_only
		unless current_user.admin? || current_user.moderator?
			flash[:notice] = "Sorry. Access denied."
			return redirect_back(fallback_location: root_path)
		end
	end
end
