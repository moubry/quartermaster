class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)

    # alert = UIAlertView.new
    # alert.message = "Hello World!"
    # alert.show
    # App.alert("BubbleWrap is awesome!")

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    # @window.rootViewController = DecksController.alloc.init
    @window.rootViewController = UINavigationController.alloc.initWithRootViewController(DecksController.alloc.init)
    @window.makeKeyAndVisible

    true
  end

end
