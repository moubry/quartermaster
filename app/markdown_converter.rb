class MarkdownConverter

  def self.url_to_html(url)
    raise 'not implemented'
    # [self.webView loadHTMLString:htmlContent baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    # url = NSURL.URLWithString("http://www.google.com/")
    # request = NSURLRequest.requestWithURL(url)
    # self.view.loadRequest request
  end

  def self.file_to_html(filename)
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
    SundownWrapper.convertMarkdownString(markdown)
  end

end
