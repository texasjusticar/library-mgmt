class ApplicationController < ActionController::API
  before_action :authenticate

  class NotAuthorized < StandardError; end

  rescue_from NotAuthorized do |exception|
    render json: { error: 'Unauthorized' }, status: 401
  end

  private

  def authenticate
    pattern = /^Bearer /
    header  = request.headers['Authorization']
    token = header.gsub(pattern, '') if header && header.match(pattern)
    authenticated_user = Librarian.find_by(auth_token: token )
    
    raise NotAuthorized unless authenticated_user
  end
end
