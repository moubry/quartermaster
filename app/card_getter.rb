class CardGetter
  def self.getCards(elements)
    cards = []

    current_category = nil
    current_card = nil

    elements.each do |e|

      if category?(e)

        if current_card
          cards << current_card
          current_card = nil
        end

        current_category = e.to_html

      elsif front?(e)

        if current_card
          cards << current_card
          current_card = nil
        end

        current_card = Card.new(front: e.to_html, category: current_category)

      else # must be back content

        current_card.add_to_back(e.to_html)

      end

    end if elements

    # last card
    if current_card
      cards << current_card
      current_card = nil
    end

    cards
  end


  def self.category?(e)
    e.name == 'h2'
  end

  def self.front?(e)
    e.name == 'h3'
  end

end
