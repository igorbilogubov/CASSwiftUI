import CleverAdsSolutions
import SwiftUI

struct InterstitialContentView: View {
    @State private var showGameOverAlert = false
    private let adViewControllerRepresentable = AdViewControllerRepresentable()
    let navigationTitle: String
    
    var adViewControllerRepresentableView: some View {
        adViewControllerRepresentable
            .frame(width: .zero, height: .zero)
    }
    
    private let coordinator = InterstitialAdCoordinator()
    
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Interstitial")
                .background(adViewControllerRepresentableView)
            
            Spacer()
            
            Button("Show interstitial") {
                print("ShowAd")
                coordinator.viewController = adViewControllerRepresentable.viewController
                coordinator.loadAd()
            }
            .font(.title2)
            .opacity(1)
            
            Spacer()
        }
        .navigationTitle(navigationTitle)
    }
}

struct InterstitialContentView_Previews: PreviewProvider {
    static var previews: some View {
        InterstitialContentView(navigationTitle: "Interstitial")
    }
}

private struct AdViewControllerRepresentable: UIViewControllerRepresentable {
    let viewController = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

private class InterstitialAdCoordinator: NSObject, CASLoadDelegate, CASCallback {
    var viewController: UIViewController?
    
    func loadAd() {
        if let manager = CAS.manager {
            manager.adLoadDelegate = self
            manager.loadInterstitial()
        }
    }
    
    func presentAd() {
        if let manager = CAS.manager {
            if let viewController = viewController {
                manager.presentInterstitial(fromRootViewController: viewController, callback: self)
            }
        }
    }
    
    func onAdLoaded(_ adType: CASType) {
        if (adType == .interstitial){
            // Interstitial loaded
            presentAd()
        }
    }
    
    func onAdFailedToLoad(_ adType: CASType, withError error: String?) {
        if (adType == .interstitial){
            // Interstitial failed to load with error
        }
    }
    
    func willShown(ad adStatus: CASImpression) {
        // Ad will present content
    }
    
    func didShowAdFailed(error: String) {
        // Ad did fail to present content.
    }
    
    func didClickedAd() {
        // Ad did click content
    }
    
    func didCompletedAd() {
        // Ad did complete content
    }
    
    func didClosedAd() {
        // Ad did dismiss content.
    }
}
