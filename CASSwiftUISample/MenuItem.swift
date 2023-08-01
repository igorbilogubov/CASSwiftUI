import Foundation
import SwiftUI

enum MenuItem: String, Identifiable {
  var id: Self { self }

  case banner = "Banner"
  case interstitial = "Interstitial"
  case rewarded = "Rewarded"

  var contentView: some View {
    return viewForType()
  }
}

extension MenuItem {
  @ViewBuilder
  private func viewForType() -> some View {
    switch self {
    case .banner:
      BannerContentView(navigationTitle: self.rawValue)
    case .interstitial:
      InterstitialContentView(navigationTitle: self.rawValue)
    case .rewarded:
      RewardedContentView(navigationTitle: self.rawValue)
    }
  }
}
