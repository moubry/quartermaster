# A "sheet" is a cheatsheet representation of a deck.
# It's a single UIWebView that contains *all* the cards.

class SheetViewController < UIViewController
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
    html_content = head + MarkdownConverter.file_to_html(@filename)
    html_content = MarkdownConverter.get_first_card(html_content)
    self.view.loadHTMLString(html_content, baseURL:nil)
  end

  def selected_file(filename)
    @filename = filename
  end
end
