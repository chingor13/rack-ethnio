module Rack
  class Ethnio
    STORAGE_KEY = 'rack.ethnio'

    def initialize(app, options = {})
      @app = app
    end

    def call(env); dup._call(env); end

    def _call(env)
      @status, @headers, @body = @app.call(env)

      return [@status, @headers, @body] unless html? && env[STORAGE_KEY]
      response = Rack::Response.new([], @status, @headers)
      @events = Array(env[STORAGE_KEY])

      if response.ok?
        # get any stored events
        session = env["rack.session"]
        stored_events = session.delete(STORAGE_KEY) if session
        @events += stored_events if stored_events
      elsif response.redirection? && env["rack.session"]
        # Store the events until next time
        env["rack.session"][STORAGE_KEY] = env[STORAGE_KEY]
      end

      @body.each {|fragment| response.write inject(fragment, @events) }
      @body.close if @body.respond_to?(:close)

      response.finish
    end

    private

    def html?
      @headers['Content-Type'] =~ /html/
    end

    def inject(response, keys)
      response.gsub(%r{</body>}, Array(keys).map{|key| message(key)}.join("") + "</body>")
    end

    def message(tracker_code)
      %{<script type="text/javascript">(function(){setTimeout(function(){var s = document.createElement('script');s.type="text/javascript";s.async=true;s.src="//ethn.io/remotes/#{tracker_code}.js";var x=document.getElementsByTagName('script')[0];x.parentNode.insertBefore(s,x);},1)})();</script>}
    end

  end
end