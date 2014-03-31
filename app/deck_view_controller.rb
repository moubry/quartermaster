class DeckViewController < UIViewController
  def viewDidLoad
    super

    cards = get_cards(@filename)
    puts "got #{cards.count} cards"

    padding_between_cards = 40
    number_of_pages = cards.count
    navbar_height = navigationController.navigationBar.frame.size.height
    puts "navbar height is #{navbar_height}"

    # view.backgroundColor = UIColor.whiteColor
    view.backgroundColor = UIColor.colorWithRed(0.31, green:0.46, blue:0.62, alpha:1.0) # sea blue

    # scroll_view_rect = CGRectInset(view.bounds, 20, 20);

    @my_scroll_view = UIScrollView.alloc.initWithFrame(view.bounds)
    @my_scroll_view.pagingEnabled = true # equals YES
    @my_scroll_view.contentSize = CGSizeMake(
      view.bounds.size.width * number_of_pages,
      1 #view.bounds.size.height - 20, # for navigation header
    )
    view.addSubview(@my_scroll_view)

    # lorem = '<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus eu tempus arcu. Morbi ut libero risus.</p>'
    # card1 = '<h1>1st!</h1>' + lorem
    # card2 = '<b>The second card of three total cards</b>' + lorem + lorem + lorem + lorem + lorem + lorem + lorem + lorem + lorem
    # card3 = '<b>Last and Final Card</b>' + lorem
    # cards = [card1, card2, card3]

    image_view_rect = CGRectInset(view.bounds, 20, 20) # image_view_rect = view.bounds
    image_view_rect.size.height = image_view_rect.size.height - navbar_height - 20

    cards.each do |card|
      # puts "card: #{card}"
      puts rect_info image_view_rect
      @my_scroll_view.addSubview CardView.create(card, image_view_rect)

      # prepare frame for the next card...
      image_view_rect.origin.x += image_view_rect.size.width + padding_between_cards
    end
  end

  # def viewDidAppear(animated)

    # http://stackoverflow.com/questions/728014/uiscrollview-paging-horizontally-scrolling-vertically
    # scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * NumberOfPages, 1);


  # end

  def selected_file(filename)
    @filename = filename
  end

  private

  def get_cards(filename)
    html = MarkdownConverter.deck_file_to_html(@filename)
    elz = MarkdownConverter.elements_from_html(html)
    puts "elz: #{elz.count}"
    categories = CardGetter.getCards(elz)
    puts "categories: #{categories.count}"
    pages = []

    categories.each do |category|
      html = ''
      html << category[:category] if category[:category]
      category[:cards].each do |card|
        html << card
      end
      pages << html
    end

    pages
  end

  def rect_info(r)
    "origin(x=#{r.origin.x}, y=#{r.origin.y}) size(#{r.size.width} x #{r.size.height})"
  end
end
