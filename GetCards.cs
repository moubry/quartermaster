public ObservableCollection<Card> GetCards(bool showFrontOnly) {
  ObservableCollection<Card> _Cards = new ObservableCollection<Card>();
  XDocument html = XDocument.Parse("<deck>" + CustomControls.NativeHtmlRenderer.ConvertToXHTML(new Markdown().Transform(Markdown)) + "</deck>");
  var n = html.Root.Elements().GetEnumerator();

  Card currentCard = null;
  int cardOrder = 1;
  string currentCategory = null;

  while (n.MoveNext()) {
    if (n.Current.Name.LocalName == "h2") {
      var h2 = n.Current;
      currentCategory = null;

      if (n.MoveNext()) {
        // h2 is category
        if (n.Current.Name.LocalName == "h3") {
          currentCategory = h2.Value;
          currentCard = new Card(showFrontOnly, currentCategory, cardOrder++);
          currentCard.Front.Root.Add(n.Current);
          _Cards.Add(currentCard);
        }
        else if (n.Current.Name.LocalName != "h2") {
          currentCard = new Card(showFrontOnly, currentCategory, cardOrder++);
          currentCard.Front.Root.Add(h2);
          _Cards.Add(currentCard);
          currentCard.Back.Root.Add(n.Current);
        }
        // else discard an h2 that has an h2 immediately after (empty category)
      }
      else {
        // h2 is card
        currentCard = new Card(showFrontOnly, currentCategory, cardOrder++);
        currentCard.Front.Root.Add(h2);
        _Cards.Add(currentCard);
      }
    }
    else if (n.Current.Name.LocalName == "h3") {
      currentCard = new Card(showFrontOnly, currentCategory, cardOrder++);
      currentCard.Front.Root.Add(n.Current);
      _Cards.Add(currentCard);
    }
    else {
      // if currentCard was null, it just means it's the title and metatdata before the deck starts.
      if (currentCard != null)
        currentCard.Back.Root.Add(n.Current);
    }
  }

  return _Cards;
}