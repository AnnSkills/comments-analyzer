class ApiBadResponseError < StandardError
  def initialize(status_code)
    @http_status = status_code
  end

  def code
    'not_available_response'
  end

  def to_hash
    {
      message: message,
      code: code
    }
  end

  def message
    "Bad response error."
  end

  def render_error_response(exception)
    render json: { message: exception.message, code: exception.code }, status: @http_status
  end
end
