class CatchAllController < ActionController::Base
  def index
    head :bad_request
  end
end
