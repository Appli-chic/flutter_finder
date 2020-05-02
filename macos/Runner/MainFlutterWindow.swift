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

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
