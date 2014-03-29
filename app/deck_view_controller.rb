class DeckViewController < UIViewController
  def viewDidLoad
    super

    view.backgroundColor = UIColor.whiteColor

    card1 = CardView.create('<b>first card</b>')
    card2 = CardView.create('<b>second card</b>')
    card3 = CardView.create('<b>third card</b>')

    scrollViewRect = view.bounds

    @my_scroll_view = UIScrollView.alloc.initWithFrame(scrollViewRect)
    @my_scroll_view.pagingEnabled = true # equals YES
    @my_scroll_view.contentSize = CGSizeMake(scrollViewRect.size.width * 3.0, scrollViewRect.size.height)
    view.addSubview(@my_scroll_view)

    @my_scroll_view.addSubview(card1)
    @my_scroll_view.addSubview(card2)
    @my_scroll_view.addSubview(card3)
  end
end
