require 'rspec/autorun'
require_relative '../app/card_getter.rb'
require_relative '../app/card.rb'

describe 'CardGetter.getCards()' do

  it 'exists' do
    expect(CardGetter).to respond_to(:getCards)
  end

  it 'returns categories with cards (happy path)' do
    cards = CardGetter.getCards([
      double(name: 'h2', to_html: '<h2>Basics</h2>'),
      double(name: 'h3', to_html: '<h3>Everything in Ruby is an...</h3>'),
      double(name: 'p',  to_html: '<p>object</p>'),
      double(name: 'p',  to_html: '<p>Even simple numeric literals!</p>'),
      double(name: 'h3', to_html: '<h3>Should Ruby code have lots of comments?</h3>'),
      double(name: 'p',  to_html: '<p>No!</p>'),
      double(name: 'p',  to_html: '<p>Good code is like a good joke: it needs no explanation.</p>'),
      double(name: 'h2', to_html: '<h2>factory_girl</h2>'),
      double(name: 'h3', to_html: '<h3>What is the difference between create, build, and generate?</h3>'),
      double(name: 'p',  to_html: '<p>create makes a saved instance.</p>'),
      double(name: 'p',  to_html: '<p>build makes an unsaved instance.</p>'),
      double(name: 'p',  to_html: '<p>generate makes a sequenced instance.</p>')
    ])

    expect(cards).to eql([
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
    ])
  end

  it 'returns a single category with a single card' do
    cards = CardGetter.getCards([
      double(name: 'h2', to_html: '<h2>Basics</h2>'),
      double(name: 'h3', to_html: '<h3>Everything in Ruby is an...</h3>'),
      double(name: 'p',  to_html: '<p>object</p>'),
      double(name: 'p',  to_html: '<p>Even simple numeric literals!</p>')
    ])

    expect(cards).to eql([
      Card.new(
        category: '<h2>Basics</h2>',
        front: '<h3>Everything in Ruby is an...</h3>',
        back: '<p>object</p><p>Even simple numeric literals!</p>'
      )
    ])
  end

  it 'returns a single card with a front and a back' do
    cards = CardGetter.getCards([
      double(name: 'h3', to_html: '<h3>Everything in Ruby is an...</h3>'),
      double(name: 'p',  to_html: '<p>object</p>'),
      double(name: 'p',  to_html: '<p>Even simple numeric literals!</p>')
    ])

    expect(cards).to eql([
      Card.new(
        front: '<h3>Everything in Ruby is an...</h3>',
        back: '<p>object</p><p>Even simple numeric literals!</p>'
      )
    ])
  end

  it 'returns an empty array for an empty category (h2 without cards)' do
    # a category without cards isn't a thing
    cards = CardGetter.getCards([
      double(name: 'h2', to_html: '<h2>Basics</h2>')
    ])
    expect(cards).to eql([])
  end

  it 'returns an empty array for empty elements' do
    cards = CardGetter.getCards([])
    expect(cards).to eql([])
  end

  it 'returns an empty array for nil elements' do
    cards = CardGetter.getCards(nil)
    expect(cards).to eql([])
  end

end
