import CleverAdsSolutions
import SwiftUI

struct RewardedContentView: View {
    @State private var coins: Int = 0
    @State private var showGameOverAlert = false
    private let adViewControllerRepresentable = AdViewControllerRepresentable()
    let navigationTitle: String
    
    var adViewControllerRepresentableView: some View {
        adViewControllerRepresentable
            .frame(width: .zero, height: .zero)
    }
    
    private let coordinator = RewardedAdCoordinator()
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            
            Button("Show rewarded") {
                print("ShowAd")
                coordinator.viewController = adViewControllerRepresentable.viewController
                coordinator.loadAd()
            }
            .font(.title2)
            .opacity(1)
            .background(adViewControllerRepresentableView)
            
            Spacer()
        }
        .navigationTitle(navigationTitle)
    }
}

struct RewardedContentView_Previews: PreviewProvider {
    static var previews: some View {
        RewardedContentView(navigationTitle: "Rewarded Ads")
    }
}

private struct AdViewControllerRepresentable: UIViewControllerRepresentable {
    let viewController = UIViewController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
}

private class RewardedAdCoordinator: NSObject, CASLoadDelegate, CASCallback {
    var viewController: UIViewController?
    
    func loadAd() {
        if let manager = CAS.manager {
            manager.adLoadDelegate = self
            manager.loadRewardedAd()
        }
    }
    
    func showAd() {
        if let manager = CAS.manager {
            if let viewController = viewController {
                manager.presentRewardedAd(fromRootViewController: viewController, callback: self)
            }
        }
    }
    
    func onAdLoaded(_ adType: CASType) {
        if (adType == .rewarded){
            // Interstitial loaded
            showAd()
        }
    }
    
    func onAdFailedToLoad(_ adType: CASType, withError error: String?) {
        if (adType == .rewarded){
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
