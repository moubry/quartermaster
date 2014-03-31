class DecksController < UITableViewController
  def viewDidLoad
    view = UITableView.alloc.init
    view.dataSource = view.delegate = self
    navigationItem.title = "Decks"
    @decks = []
    @decks.clear

    # json_data = get_results_data
    # json = get_json(json_data)

    # new_tweets = []
    # json['decks'].each do |dict|
    #   new_tweets << Tweet.new(dict)
    # end

    files = NSFileManager.defaultManager.directoryContentsAtPath(App.resources_path + '/decks')
    files.select! { |f| f.end_with?('.md') }

    files.each do |f|
      @decks << Deck.new({:title => f, :filename => f})
    end

    view.reloadData
  end

  def get_results_data
    error_ptr = Pointer.new(:object)
    data = NSData.alloc.initWithContentsOfFile(
      App.resources_path + '/results.json',
      options:NSDataReadingUncached,
      error:error_ptr
    )
    unless data
      raise error_ptr[0]
    end
    data
  end

  def get_json(data)
    error_ptr = Pointer.new(:object)
    json = NSJSONSerialization.JSONObjectWithData(data, options:0, error:error_ptr)
    unless json
      raise error_ptr[0]
    end
    json
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @decks.size
  end

  CellID = 'CellIdentifier'
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    deck = @decks[indexPath.row]
    cell = tableView.dequeueReusableCellWithIdentifier(CellID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier:CellID)
    cell.textLabel.text = deck.title
    cell.detailTextLabel.text = "Written by " + deck.author if deck.author
    cell
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    deck = @decks[indexPath.row]

    detail_controller = load_deck_detail_view_controller
    detail_controller.selected_file(deck.filename)
    self.navigationController.pushViewController(detail_controller, animated:true)

    tableView.deselectRowAtIndexPath(indexPath, animated:true)
  end

  def load_deck_detail_view_controller
    # load the cheat sheet view
    # SheetViewController.alloc.init

    # load the swipey card view
    DeckViewController.alloc.init
  end

    # font_dict = fonts[indexPath.section]
    # font_name = font_dict[:fonts][indexPath.row]

    # @detail_controller ||= DetailController.alloc.init
    # @detail_controller.selected_font(font_name)
    # self.navigationController.pushViewController(@detail_controller, animated:true)

    # tableView.deselectRowAtIndexPath(indexPath, animated:true)

end
