class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)

    # alert = UIAlertView.new
    # alert.message = "Hello World!"
    # alert.show
    # App.alert("BubbleWrap is awesome!")

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.makeKeyAndVisible

    # debugging the decks controller
    # @window.rootViewController = DecksController.alloc.init

    # the production app path
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(
      # loads a table view for choosing from a list of decks
      DecksController.alloc.init
    )
    # @window.makeKeyAndVisible

    # debugging the deck view controller
    # @window.rootViewController = DeckViewController.alloc.init
    # @window.rootViewController = DeckViewController.new

    @window.rootViewController.wantsFullScreenLayout = true
    true
  end

end
