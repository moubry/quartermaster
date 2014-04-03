class DeckViewController < UIViewController

  PADDING_BETWEEN_CARDS = 40
  BACKGROUND_COLOR = UIColor.colorWithRed(0.31, green:0.46, blue:0.62, alpha:1.0)

  def viewDidLoad
    super

    cards = Cards.from_filename(@filename, :type => :category_cards)

    number_of_pages = cards.count
    navbar_height = navigationController.navigationBar.frame.size.height
    puts "navbar height is #{navbar_height}"

    view.backgroundColor = BACKGROUND_COLOR # sea blue

    # scroll_view_rect = CGRectInset(view.bounds, 20, 20);

    @my_scroll_view = UIScrollView.alloc.initWithFrame(view.bounds)
    @my_scroll_view.pagingEnabled = true
    @my_scroll_view.contentSize = CGSizeMake(
      view.bounds.size.width * number_of_pages,
      1 #view.bounds.size.height - 20, # for navigation header
    )
    view.addSubview(@my_scroll_view)

    image_view_rect = CGRectInset(view.bounds, 20, 20) # image_view_rect = view.bounds
    image_view_rect.size.height = image_view_rect.size.height - navbar_height - 20

    cards.each do |card|
      puts rect_info image_view_rect
      @my_scroll_view.addSubview CardView.create(card, image_view_rect)

      # prepare frame for the next card...
      image_view_rect.origin.x += image_view_rect.size.width + PADDING_BETWEEN_CARDS
    end
  end

  # def viewDidAppear(animated)
    # http://stackoverflow.com/questions/728014/uiscrollview-paging-horizontally-scrolling-vertically
    # scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * NumberOfPages, 1);
  # end

  def selected_file(filename)
    @filename = filename
  end

  # for debugging
  def rect_info(r)
    "origin(x=#{r.origin.x}, y=#{r.origin.y}) size(#{r.size.width} x #{r.size.height})"
  end
end
