import Cocoa
import FlutterMacOS

@NSApplicationMain
class AppDelegate: FlutterAppDelegate {
    var statusBar: StatusBarController?
    var popover = NSPopover.init()
    
    override init() {
        popover.behavior = NSPopover.Behavior.transient //to make the popover hide when the user clicks outside of it
    }
    
    
    override func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    return false
    }
    
    override func applicationDidFinishLaunching(_ aNotification: Notification) {
        let controller: FlutterViewController =
          mainFlutterWindow?.contentViewController as! FlutterViewController
        
        
        popover.contentSize = NSSize(width: 360, height: 155) //change this to your desired size
        popover.contentViewController = controller //set the content view controller for the popover to flutter view controller
        statusBar = StatusBarController.init(popover)
        
        
        let lockDoorChannel = FlutterMethodChannel(
            name: "last_thing/accessChannel", binaryMessenger: controller.engine.binaryMessenger
        )
                
        lockDoorChannel.setMethodCallHandler({
            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
                        
            if (call.method == "changeStatusBar") {
                if let args = call.arguments as? Dictionary<String, Any> {
                    let value = args["value"] as? String
                    let hexColor = args["hexColor"] as? String
                    
                    self?.statusBar?.changeStatusBarButton(thing: value, hex: hexColor)
                    self?.popover.close()
                }
            } else if (call.method == "exitApp") {
                exit(0)
            }
        })
        
                
        mainFlutterWindow.close() //close the default flutter window
        super.applicationDidFinishLaunching(aNotification)
      }
}
