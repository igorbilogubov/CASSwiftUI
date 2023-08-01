//import GoogleMobileAds
import CleverAdsSolutions
import SwiftUI

struct BannerContentView: View {
    let navigationTitle: String
    
    var body: some View {
        BannerView()
            .navigationTitle(navigationTitle)
    }
}

struct BannerContentView_Previews: PreviewProvider {
    static var previews: some View {
        BannerContentView(navigationTitle: "Banner")
    }
}

private struct BannerView: UIViewControllerRepresentable {
    private let bannerView: CASBannerView = CASBannerView(adSize: CASSize.banner, manager: CAS.manager)
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let bannerViewController = BannerViewController()
        bannerView.rootViewController = bannerViewController
        bannerView.isAutoloadEnabled = true
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        bannerViewController.view.addSubview(bannerView)
        // Constrain GADBannerView to the bottom of the view.
        NSLayoutConstraint.activate([
            bannerView.bottomAnchor.constraint(
                equalTo: bannerViewController.view.safeAreaLayoutGuide.bottomAnchor),
            bannerView.centerXAnchor.constraint(equalTo: bannerViewController.view.centerXAnchor),
        ])
        return bannerViewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    fileprivate class Coordinator: NSObject, CASBannerDelegate {
        let parent: BannerView
        
        init(_ parent: BannerView) {
            self.parent = parent
        }
        
        func bannerViewController(
            _ bannerViewController: BannerViewController, didUpdate width: CGFloat
        ) {
            parent.bannerView.adDelegate = self
        }
        
        func bannerAdViewDidLoad(_ view: CASBannerView){
            // Invokes this callback when ad loaded and ready to present.
        }
        
        func bannerAdView(_ adView: CASBannerView, didFailWith error: CASError){
            // Invokes this callback when an error occurred with the ad.
            // - To see a description of the error, see `CASError.message`.
        }
        
        func bannerAdView(_ adView: CASBannerView, willPresent impression: CASImpression){
            // Invokes this callback when the ad will presenting for user with info about the impression.
        }
        
        func bannerAdViewDidRecordClick(_ adView: CASBannerView){
            // Invokes this callback when a user clicks the ad.
        }
    }
}

protocol BannerViewControllerWidthDelegate: AnyObject {
    func bannerViewController(_ bannerViewController: BannerViewController, didUpdate width: CGFloat)
}

class BannerViewController: UIViewController {
    
    weak var delegate: BannerViewControllerWidthDelegate?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        delegate?.bannerViewController(
            self, didUpdate: view.frame.inset(by: view.safeAreaInsets).size.width)
    }
    
    override func viewWillTransition(
        to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator
    ) {
        coordinator.animate { _ in
            // do nothing
        } completion: { _ in
            self.delegate?.bannerViewController(
                self, didUpdate: self.view.frame.inset(by: self.view.safeAreaInsets).size.width)
        }
    }
}
