class RequestContext
  attr_reader :url, :remote_host, :remote_ident, :remote_user, :remote_addr, :remote_ip

  # @param env [Hash] an instance of Hash that includes CGI-like headers
  def initialize(env)
    @env = env
  end

  def url
    @env["REQUEST_URI"]
  end

  def path_info
    @env["PATH_INFO"]
  end

  def remote_host
    @env["REMOTE_HOST"]
  end

  def remote_addr
    @env["REMOTE_ADDR"]
  end

  # @param request [ActionDispatch::Request]
  # @return [RequestContext]
  def self.wrap(request)
    new(request.env)
  end
end
