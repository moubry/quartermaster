class Cards

  def self.from_filename(filename, opts = {})
    html = MarkdownConverter.deck_file_to_html(filename)
    elz = MarkdownConverter.elements_from_html(html)
    categories = CardGetter.getCards(elz)

    card_type = opts[:type] || :two_sided_cards
    cards = send("as_#{card_type}", categories)

    puts "Cards.from_filename(#{filename}): #{cards.count} cards"
    cards
  end

  def self.as_sheet_cards
    raise 'not implemented'
  end

  def self.as_category_cards(categories)
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

  def self.as_two_sided_cards
    raise 'not implemented'
  end

end
