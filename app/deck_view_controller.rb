class DeckViewController < UIViewController
  def viewDidLoad
    self.view = UIWebView.alloc.init
    self.view.clipsToBounds = true
    # self.view.scrollView.scrollEnabled = false
    # self.view.scrollView.bounces = false


    # flipping a uiview
    # [UIView beginAnimations:@"flipView" context:nil];
    # [UIView setAnimationDuration:0.3f];
    # [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:view1 cache:YES];
    # [view1 addSubview:view2];
    # [UIView commitAnimations];
    # ... and for a vertical flip, do this: http://stackoverflow.com/questions/5392629/uiview-vertical-flip-animation
    # http://developer.apple.com/library/ios/#documentation/WindowsViews/Conceptual/ViewPG_iPhoneOS/AnimatingViews/AnimatingViews.html

  end

  def viewDidAppear(animated)
    # url = NSURL.URLWithString("http://www.google.com/")
    # request = NSURLRequest.requestWithURL(url)
    # self.view.loadRequest request

    error_ptr = Pointer.new(:object)

    md = NSString.stringWithContentsOfFile(
      App.resources_path + '/decks/' + @filename,
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
      html_content = "<h1>Ugh, an error.</h1><blockquote>" + error.class.to_s + ' - ' + error.description.to_s+ "</blockquote>"
    else
      html_content = "You should never get here."
    end

    self.view.loadHTMLString(html_content, baseURL:nil)

    # [self.webView loadHTMLString:htmlContent baseURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]]];
  end

  def selected_file(filename)
    @filename = filename
  end
end
