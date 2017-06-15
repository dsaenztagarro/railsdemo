#
# Wraps information that needs to be used in different parts of the application,
# and that depends on who is currently using the application. Among this
# information, it is:
#
# * the current user
# * the current timezone and locales
# * access and refresh token to access id on behalf of the current user
#
class CurrentEnv
  attr_reader :request_context

  attr_accessor :current_job # [BebanjoJobs::Job]

  # @param request [ActionDispatch::Request]
  def request_context=(request)
    @request_context = RequestContext.wrap(request)
  end

  class << self
    # Factory - Builds current environment from session and request data
    def from_session_and_request(session, request)
      instance.tap do |env|
        env.request_context = request
      end
    end

    def instance
      Thread.current[:env] ||= self.new
    end
  end
end
