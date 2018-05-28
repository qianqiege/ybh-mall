module Helpers
  module ApiStrongParametersHelper


    protected
    def raw_parameters(parameters)
      ActionController::Parameters.new(parameters)
    end

    # usage example: user_params[:avatar] = tempfile_to_uploaded_file(user_params[:avatar])
    def tempfile_to_uploaded_file(tempfile)
      if tempfile && tempfile.is_a?(Hash) && tempfile[:tempfile]
        ActionDispatch::Http::UploadedFile.new tempfile
      else
        tempfile
      end
    end
  end
end
