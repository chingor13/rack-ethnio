require 'test_helper'

class EthnioTest < MiniTest::Unit::TestCase

  def test_embeds_meta_at_end_of_html_head
    response = request(12345)
    doc = Nokogiri::HTML(response.body)
    scripts = doc.search('html body script')
    assert_equal(1, scripts.count)

    script = scripts.first
    assert(script.text.match("//ethn.io/remotes/12345.js"))
  end

  def test_does_nothing_on_non_html
    response = request(12345, {content_type: 'text/javascript'})
    assert_equal(HTML_DOC, response.body)
  end

  def test_does_nothing_when_no_body_tag
    response = request(12345, {body: ["Some text"]})
    assert_equal("Some text", response.body)
  end

  protected

  HTML_DOC = <<-EOF
    <html>
      <head>
        <title>Rack::Metadata</title>
      </head>
      <body>
        <h1>Rack::Metadata</h1>
      </body>
    </html>
  EOF

  def request(ethnio, opts = {})
    body = opts.delete(:body) || [HTML_DOC]
    content_type = opts.delete(:content_type) || "text/html"
    app = lambda { |env| 
      env['rack.ethnio'] = ethnio if ethnio
      [200, {'Content-Type' => content_type}, body]
    }
    @application = Rack::Ethnio.new(app, opts)
    @request = Rack::MockRequest.new(@application).get("/")
    yield(@application, @request) if block_given?
    @request
  end

end 