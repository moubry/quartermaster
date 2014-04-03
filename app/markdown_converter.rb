class MarkdownConverter

  def self.url_to_html(url)
    raise 'not implemented'
    # [self.webView loadHTMLString:htmlContent baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    # url = NSURL.URLWithString("http://www.google.com/")
    # request = NSURLRequest.requestWithURL(url)
    # self.view.loadRequest request
  end

  def self.deck_file_to_html(filename)
    file_to_html File.join(App.resources_path, 'decks', filename)
  end

  def self.deck_file_to_markdown(filename)
    file_to_markdown File.join(App.resources_path, 'decks', filename)
  end

  def self.file_to_markdown(filepath)
    error_ptr = Pointer.new(:object)

    md = NSString.stringWithContentsOfFile(
      filepath,
      encoding:NSUTF8StringEncoding,
      error:error_ptr
    )

    if error = error_ptr[0]
      return markdown_for_error(error)
    end

    md
  end

  def self.file_to_html(filename)
    md = file_to_markdown(filename)
    html = markdown_to_html(md)
  end

  def self.elements_from_html(html)
    doc = Wakizashi::HTML('<html><body>' + html + '</body></html>')
    elz = doc.xpath('/html/body/*')
    elz
  end

  def self.markdown_to_html(markdown)
    SundownWrapper.convertMarkdownString(markdown)
  end

  def self.markdown_for_error(error)
"# Ugh, an error.

> #{error.class.to_s} - #{error.description.to_s}"
  end

end
