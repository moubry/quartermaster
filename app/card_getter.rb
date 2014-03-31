class CardGetter
  def self.getCards(elements)
    categories = []

    # initial everything bucket (uncategoried by default)
    current_category = {
      category: nil,
      cards: []
    }

    elements.each do |e|

      if e.name == 'h2'

        # uhh... do we already have a category?
        if current_category
          # quick get rid of him, fast
          categories << current_category
          # clean up
          current_category = nil
        end

        # heeeey, nice to meet you category!
        current_category = {
          category: e.to_html,
          cards: []
        }

      else

        current_category[:cards] << e.to_html

      end

    end if elements

    # closing time, last category! everyone out!
    categories << current_category

    # remove uncategorized if it's empty
    if uncategorized = categories && categories.first
      if uncategorized[:cards].count == 0
        categories.shift
      end
    end

    categories
  end
end
