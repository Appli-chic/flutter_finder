import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
    
    override func awakeFromNib() {
        let flutterViewController = FlutterViewController.init()
        let windowFrame = self.frame
        self.contentViewController = flutterViewController
        self.setFrame(windowFrame, display: true)
        
        // Transaprent titlebar
        self.titleVisibility = .hidden
        self.styleMask.insert(.fullSizeContentView)
        self.titlebarAppearsTransparent = true
        self.contentView?.wantsLayer = true
        self.contentView?.layer?.contents = NSImage(named: NSImage.Name("Background"))
        
        let fileManagerChannel = FlutterMethodChannel(name: "plugins.applichic/file_manager",
                                                      binaryMessenger: flutterViewController.engine.binaryMessenger)
        
        fileManagerChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            
            // Get home path
            if call.method == "getHomePath" {
                self.getHomePath(result: result)
            } else if call.method == "getDownloadPath" {
                self.getDownloadPath(result: result)
            } else if call.method == "getDocumentPath" {
                self.getDocumentPath(result: result)
            } else if call.method == "getDesktopPath" {
                self.getDesktopPath(result: result)
            } else {
                result("/")
            }
        })
        
        RegisterGeneratedPlugins(registry: flutterViewController)
        super.awakeFromNib()
    }
    
    private func getHomePath(result: FlutterResult) {
        var home: String
        
        if #available(OSX 10.12, *) {
            home = FileManager.default.homeDirectoryForCurrentUser.path
        } else {
            home = URL(fileURLWithPath: NSHomeDirectory()).path
        }
        
        result(home)
    }
    
    private func getDownloadPath(result: FlutterResult) {
        let downloadsDirectory = FileManager.default.urls(for: .downloadsDirectory, in: .userDomainMask).first?.path
        result(downloadsDirectory)
    }
    
    private func getDocumentPath(result: FlutterResult) {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.path
        result(documentDirectory)
    }
    
    private func getDesktopPath(result: FlutterResult) {
        let desktopDirectory = FileManager.default.urls(for: .desktopDirectory, in: .userDomainMask).first?.path
        result(desktopDirectory)
    }
}
