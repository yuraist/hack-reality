import SwiftUI

class SessionSettings: ObservableObject {
  @Published var isPeopleOcclusionEnabled = false
  @Published var isObjectOcclusionEnabled = false
  @Published var isLidarDebugEnabled = false
  @Published var isMultiuserEnabled = false
}
