require 'yajl'

class Api::Controller < ActionController::Metal
  include ActionController::Rendering
  include ActionController::MimeResponds
  include ActionController::Renderers::All

  respond_to :json
end
