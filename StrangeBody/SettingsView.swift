import SwiftUI

enum Setting {
  case peopleOcclusion
  case objectOcclusion
  case lidarDebug
  case multiuser
  
  var label: String {
    switch self {
    case .peopleOcclusion, .objectOcclusion:
      return "Occlusion"
    case .lidarDebug:
      return "LiDAR"
    case .multiuser:
      return "Multiuser"
    }
  }
  
  var systemIconName: String {
    switch self {
    case .peopleOcclusion:
      return "person"
    case .objectOcclusion:
      return "cube.box.fill"
    case .lidarDebug:
      return "light.min"
    case .multiuser:
      return "person.2"
    }
  }
}

struct SettingsView: View {
  
  @Binding var showSettings: Bool
  
  var body: some View {
    NavigationView {
      SettingsGrid()
        .navigationTitle("Settings")
        .toolbar {
          ToolbarItem(placement: .navigationBarTrailing) {
            Button {
              showSettings.toggle()
            } label: {
              Text("Done").bold()
            }
          }
        }
    }
  }
}

struct SettingsGrid: View {
  
  @EnvironmentObject var sessionSettings: SessionSettings
  
  private let gridLayout = [GridItem(.adaptive(minimum: 100, maximum: 100), spacing: 25)]
  
  var body: some View {
    ScrollView {
      LazyVGrid(columns: gridLayout) {
        SettingToggleButton(setting: .peopleOcclusion, isOn: $sessionSettings.isPeopleOcclusionEnabled)
        SettingToggleButton(setting: .objectOcclusion, isOn: $sessionSettings.isObjectOcclusionEnabled)
        SettingToggleButton(setting: .lidarDebug, isOn: $sessionSettings.isLidarDebugEnabled)
        SettingToggleButton(setting: .multiuser, isOn: $sessionSettings.isMultiuserEnabled)
      }
    }
  }
}

struct SettingToggleButton: View {
  
  let setting: Setting
  @Binding var isOn: Bool
  
  var body: some View {
    Button {
      isOn.toggle()
      print("\(#file) - \(setting): \(isOn)")
    } label: {
      VStack {
        Image(systemName: setting.systemIconName)
          .font(.system(size: 35))
          .foregroundColor(isOn ? .green : Color(UIColor.secondaryLabel))
          .buttonStyle(.plain)
        
        Text(setting.label)
          .font(.system(size: 17, weight: .medium))
          .foregroundColor(isOn ? Color(UIColor.label) : Color(UIColor.secondaryLabel))
          .padding(.top, 5)
      }
    }
    .frame(width: 100, height: 100)
    .background(Color(UIColor.secondarySystemFill))
    .cornerRadius(20)
  }
}
