module FacebookFailResponse
    extend ActiveSupport::Concern
    def failed_response(error)
        flash[:error] = error
        respond_to do |format|
            format.js { render :js => "window.location = '/admin/fb_settings/edit'" }
            format.html { redirect_back(fallback_location: location_after_save) }
        end
    end
end