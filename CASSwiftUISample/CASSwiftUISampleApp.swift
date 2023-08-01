import CleverAdsSolutions
import SwiftUI

class AppDelegate: NSObject, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Configure CAS.settings before initialize
        // Configure CAS.targetingOptions before initialize
        let manager = getAdManager()
        return true
    }
    
    func getAdManager() -> CASMediationManager {
        return CAS.buildManager()
            // List Ad formats used in app
            .withAdTypes(CASType.banner, CASType.interstitial, CASType.rewarded)
            // Set Test ads or live ads
            .withTestAdMode(true)
            .withCompletionHandler({ initialConfig in
                if let error = initialConfig.error {
                   print("CAS Initialization failed: \(error)")
                } else {
                   print("CAS Initialization completed")
                }
            })
            // Set your CAS ID
            .create(withCasId: "demo")
    }
    
  
}

@main
struct CASSwiftUISampleApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        
        WindowGroup {
            ContentView()
        }
    }
}
