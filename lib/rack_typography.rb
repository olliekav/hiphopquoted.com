module Rack
  class Typography
    # When switching to a new webfont, Hoefler Frere-Jones' typography.com runs
    # an HTTP GET confirmation step against our font directory to see if we've
    # installed it correctly. Because the directory returns 404 by default,
    # we're unable to confirm the step. This middleware returns 200 OK for all
    # possible /fonts/[:digits] routes that H&FJ may generate so that the
    # confirmation step will pass.

    def initialize(app)
      @app = app
    end

    def call(env)
      if env['REQUEST_PATH'] =~ /^\/fonts\/\d+$/
        [200, { 'Content-Type' => 'text/html' }, ['']]
      else
        @app.call(env)
      end
    end
  end
end