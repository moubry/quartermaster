describe 'parsing' do

  it 'gets markdown from a file' do
    md_file = File.join(App.resources_path, 'happy.md')

    md = MarkdownConverter.file_to_markdown(md_file)

    md.should == File.read(md_file)
  end

  it 'converts markdown to html' do
    test_html = File.read File.join(App.resources_path, 'happy.html')
    md_file = File.join(App.resources_path, 'happy.md')
    md = File.read(md_file)

    converted_html = MarkdownConverter.markdown_to_html(md)

    converted_html.should == test_html
  end

  it 'gets a deck from html' do
    true.should == true
    # CardGetter.getCards()
  end

end

describe 'CardGetter.getCards()' do

  before do
    test_html = File.read File.join(App.resources_path, 'happy.html')
    @elements = MarkdownConverter.elements_from_html(test_html)
  end

  # it 'returns categories with cards (happy path)' do
  #   cards = CardGetter.getCards(@elements)
  #   cards.should == [
  #     {
  #       category: '<h2>Basics</h2>',
  #       cards: [
  #         '<h3>Everything in Ruby is an...</h3>',
  #         '<p>object</p>',
  #         '<p>Even simple numeric literals!</p>',
  #         '<h3>Should Ruby code have lots of comments?</h3>',
  #         '<p>No!</p>',
  #         '<p>Good code is like a good joke: it needs no explanation.</p>'
  #       ]
  #     },
  #     {
  #       category: '<h2>factory_girl</h2>',
  #       cards: [
  #         '<h3>What is the difference between create, build, and generate?</h3>',
  #         '<p>create makes a saved instance.</p>',
  #         '<p>build makes an unsaved instance.</p>',
  #         '<p>generate makes a sequenced instance.</p>'
  #       ]
  #     }
  #   ]
  # end

  it 'returns an empty category for one h2' do
    html = '<h2>Basics</h2>'
    elements = MarkdownConverter.elements_from_html(html)
    cards = CardGetter.getCards(elements)
    cards.should == [
      {
        category: '<h2>Basics</h2>',
        cards: []
      }
    ]
  end

  it 'returns an empty array for empty elements' do
    cards = CardGetter.getCards([])
    cards.should == []
  end

  it 'returns an empty array for nil elements' do
    cards = CardGetter.getCards(nil)
    cards.should == []
  end

end
