import CleverAdsSolutions
import SwiftUI

struct ContentView: View {
  private let items: [MenuItem] = [
    .banner,
    .interstitial,
    .rewarded
  ]

  var body: some View {
    NavigationView {
      List(items) { item in
        NavigationLink(destination: item.contentView) {
            
          Text(item.rawValue)
        }
      }
      .navigationTitle("Menu")
    }
  }
}
