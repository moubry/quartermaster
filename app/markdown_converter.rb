class MarkdownConverter

  def self.file_to_html(filename)
    # url = NSURL.URLWithString("http://www.google.com/")
    # request = NSURLRequest.requestWithURL(url)
    # self.view.loadRequest request

    error_ptr = Pointer.new(:object)

    md = NSString.stringWithContentsOfFile(
      App.resources_path + '/decks/' + filename,
      encoding:NSUTF8StringEncoding,
      error:error_ptr
    )

    error = error_ptr[0]
    if error
      return "<h1>Ugh, an error.</h1><blockquote>" + error.class.to_s + ' - ' + error.description.to_s+ "</blockquote>"
    end

    markdown_to_html(md)
  end

  def self.markdown_to_html(markdown)
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

    head + SundownWrapper.convertMarkdownString(markdown)
  end

end
