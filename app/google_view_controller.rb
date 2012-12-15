class GoogleViewController < UIViewController
  def viewDidLoad
    self.view = UIWebView.alloc.init

    # url = NSURL.URLWithString("http://www.google.com/")
    # request = NSURLRequest.requestWithURL(url)
    # self.view.loadRequest request

    error_ptr = Pointer.new(:object)

    md = NSString.stringWithContentsOfFile(
      App.resources_path + '/javascript2.md',
      encoding:NSUTF8StringEncoding,
      error:error_ptr
    )

    error = error_ptr[0]

    if md
      html_content = SundownWrapper.convertMarkdownString(md)
    elsif error
      html_content = "<h1>Ugh, an error.</h1><blockquote>" + error.class.to_s + ' - ' + error.description.to_s+ "</blockquote>"
    else
      html_content = "You should never get here."
    end

    puts html_content

    self.view.loadHTMLString(html_content, baseURL:nil)

    # [self.webView loadHTMLString:htmlContent baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
  end
end
