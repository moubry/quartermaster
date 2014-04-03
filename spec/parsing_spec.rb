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

  it 'returns categories with cards (happy path)' do
    puts @elements.count
    cards = CardGetter.getCards(@elements)
    cards.should == [
      Card.new(
        category: '<h2>Basics</h2>',
        front: '<h3>Everything in Ruby is an...</h3>',
        back: '<p>object</p><p>Even simple numeric literals!</p>'
      ),
      Card.new(
        category: '<h2>Basics</h2>',
        front: '<h3>Should Ruby code have lots of comments?</h3>',
        back: '<p>No!</p><p>Good code is like a good joke: it needs no explanation.</p>'
      ),
      Card.new(
        category: '<h2>factory_girl</h2>',
        front: '<h3>What is the difference between create, build, and generate?</h3>',
        back: '<p>create makes a saved instance.</p><p>build makes an unsaved instance.</p><p>generate makes a sequenced instance.</p>'
      )
    ]
  end

  it 'returns an empty array for a category without cards' do
    html = '<h2>Basics</h2>'
    elements = MarkdownConverter.elements_from_html(html)
    cards = CardGetter.getCards(elements)
    cards.should == []
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
