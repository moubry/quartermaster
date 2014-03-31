require 'rspec/autorun'
require_relative '../app/card_getter.rb'

describe 'CardGetter.getCards()' do

  it 'exists' do
    expect(CardGetter).to respond_to(:getCards)
  end

  it 'returns categories with cards (happy path)' do
    cards = CardGetter.getCards([
      double(name: 'h2', to_html: '<h2>Basics</h2>', to_s: 'Basics'),
      double(name: 'h3', to_html: '<h3>Everything in Ruby is an...</h3>'),
      double(name: 'p',  to_html: '<p>object</p>'),
      double(name: 'p',  to_html: '<p>Even simple numeric literals!</p>'),
      double(name: 'h3', to_html: '<h3>Should Ruby code have lots of comments?</h3>'),
      double(name: 'p',  to_html: '<p>No!</p>'),
      double(name: 'p',  to_html: '<p>Good code is like a good joke: it needs no explanation.</p>'),
      double(name: 'h2', to_html: '<h2>factory_girl</h2>', to_s: 'factory_girl'),
      double(name: 'h3', to_html: '<h3>What is the difference between create, build, and generate?</h3>'),
      double(name: 'p',  to_html: '<p>create makes a saved instance.</p>'),
      double(name: 'p',  to_html: '<p>build makes an unsaved instance.</p>'),
      double(name: 'p',  to_html: '<p>generate makes a sequenced instance.</p>')
    ])
    expect(cards).to eql([
      {
        category: '<h2>Basics</h2>',
        cards: [
          '<h3>Everything in Ruby is an...</h3>',
          '<p>object</p>',
          '<p>Even simple numeric literals!</p>',
          '<h3>Should Ruby code have lots of comments?</h3>',
          '<p>No!</p>',
          '<p>Good code is like a good joke: it needs no explanation.</p>'
        ]
      },
      {
        category: '<h2>factory_girl</h2>',
        cards: [
          '<h3>What is the difference between create, build, and generate?</h3>',
          '<p>create makes a saved instance.</p>',
          '<p>build makes an unsaved instance.</p>',
          '<p>generate makes a sequenced instance.</p>'
        ]
      }
    ])
  end

  it 'returns an empty category for one h2' do
    cards = CardGetter.getCards([
      double(name: 'h2', to_html: '<h2>Basics</h2>', to_s: 'Basics')
    ])
    expect(cards).to eql([{ category: '<h2>Basics</h2>', cards: [] }])
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
