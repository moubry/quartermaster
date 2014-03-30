class MarkdownConverter

  def self.url_to_html(url)
    raise 'not implemented'
    # [self.webView loadHTMLString:htmlContent baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
    # url = NSURL.URLWithString("http://www.google.com/")
    # request = NSURLRequest.requestWithURL(url)
    # self.view.loadRequest request
  end

  def self.file_to_markdown(filename)
    error_ptr = Pointer.new(:object)

    md = NSString.stringWithContentsOfFile(
      App.resources_path + '/decks/' + filename,
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

  def self.get_first_card(html)
    doc = Wakizashi::HTML(html)
    elz = doc.xpath('/html/body/*')

    cards = []

    elz.each do |e|
      puts e.to_s
      cards << e
    end

    html = cards.collect(&:to_html).join('')

    html
  end

  def self.markdown_to_html(markdown)
    SundownWrapper.convertMarkdownString(markdown)
  end

  def self.markdown_for_error(error)
"# Ugh, an error.

> #{error.class.to_s} - #{error.description.to_s}"
  end

end
