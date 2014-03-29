# Usage:
#   CardView.create('<b>haha</b>')
#
class CardView

  def self.create(markdown)
    webview = UIWebView.alloc.init
    webview.clipsToBounds = true

    html = get_html_from_markdown(markdown)
    add_html_to_webview(webview, html)
  end

  def self.get_html_from_markdown(markdown)
    error_ptr = Pointer.new(:object)

    md = NSString.stringWithContentsOfFile(
      markdown,
      encoding:NSUTF8StringEncoding,
      error:error_ptr
    )

    error = error_ptr[0]

    head = '
    <head>
      <meta name="viewport" content="width=device-width,initial-scale=1.0">
      <style>
        body {
          word-wrap:break-word;
          padding:15px;
          margin:0;
          font-family:Georgia;
        }
        h1, h2, h3, h4, h5 {
          font-family:Avenir;
        }
        pre, code {
          font-family:Courier;
        }
      </style>
    </head>
    '

    if md
      html_content = head + SundownWrapper.convertMarkdownString(md)
    elsif error
      html_content = '<h1>Ugh, an error.</h1><blockquote>' + error.class.to_s + ' - ' + error.description.to_s + '</blockquote>'
    else
      html_content = 'You should never get here.'
    end
  end

  def self.add_html_to_webview(webview, html)
    webview.loadHTMLString(html, baseURL:nil)
  end

end
