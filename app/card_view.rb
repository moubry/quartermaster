# Usage:
#   CardView.create('<b>haha</b>')
#
class CardView

  def self.create(markdown, frame)
    webview = UIWebView.alloc.initWithFrame(frame)
    webview.clipsToBounds = true

    html = get_html_from_markdown(markdown)
    add_html_to_webview(webview, html)
  end

  def self.get_html_from_markdown(html)
    head = '
    <head>
      <style>
        * { box-sizing: border-box; }
        html {
          background-color: rgb(232, 196, 231);
        }
        body {
          word-wrap:break-word;
          padding: 0;
          margin: 0;
          font-family:Georgia;
        }
        h1, h2, h3, h4, h5 {
          font-family:Avenir;
        }
        pre, code {
          font-family:Courier;
        }
        .card {
          //color: #edc;
          //background-color: #422;
          padding: 10px;
        }
      </style>
    </head>
    '

    html_content = "#{head} <div class=\"card\">#{html}</div>"
  end

  def self.add_html_to_webview(webview, html)
    webview.loadHTMLString(html, baseURL:nil)
  end

end
