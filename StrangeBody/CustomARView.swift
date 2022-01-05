import ARKit
import Combine
import RealityKit
import FocusEntity

class CustomARView: ARView {
  
  var focusEntity: FocusEntity?
  var sessionSettings: SessionSettings
  
  private var peopleOcclusionCancellable: AnyCancellable?
  private var objectOcclusionCancellable: AnyCancellable?
  private var lidarDebugCancellable: AnyCancellable?
  private var multiuserCancellable: AnyCancellable?
  
  required init(frame frameRect: CGRect, sessionSettings: SessionSettings) {
    self.sessionSettings = sessionSettings
    super.init(frame: frameRect)
    
    focusEntity = FocusEntity(on: self, focus: .classic)
    configure()
    setupSubscribers()
  }
  
  required init(frame frameRect: CGRect) {
    fatalError("init(frame:) has not been implemented")
  }
  
  @MainActor @objc required dynamic init?(coder decoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func configure() {
    let config = ARWorldTrackingConfiguration()
    config.planeDetection = [.horizontal, .vertical]
    
    if ARWorldTrackingConfiguration.supportsSceneReconstruction(.mesh) {
      config.sceneReconstruction = .mesh
    }
    
    session.run(config)
  }
  
  private func initializeSettings() {
    updatePeopleOcclusion(isEnabled: sessionSettings.isPeopleOcclusionEnabled)
    updateObjectOcclusion(isEnabled: sessionSettings.isObjectOcclusionEnabled)
    updateLidarDebug(isEnabled: sessionSettings.isLidarDebugEnabled)
    updateMultiuser(isEnabled: sessionSettings.isMultiuserEnabled)
  }
  
  private func setupSubscribers() {
    peopleOcclusionCancellable = sessionSettings.$isPeopleOcclusionEnabled
      .sink(receiveValue: { [weak self] isEnabled in
        self?.updatePeopleOcclusion(isEnabled: isEnabled)
    })
    
    objectOcclusionCancellable = sessionSettings.$isObjectOcclusionEnabled
      .sink(receiveValue: { [weak self] isEnabled in
        self?.updateObjectOcclusion(isEnabled: isEnabled)
    })
    
    lidarDebugCancellable = sessionSettings.$isLidarDebugEnabled
      .sink(receiveValue: { [weak self] isEnabled in
        self?.updateLidarDebug(isEnabled: isEnabled)
    })
    
    multiuserCancellable = sessionSettings.$isMultiuserEnabled
      .sink(receiveValue: { [weak self] isEnabled in
        self?.updateMultiuser(isEnabled: isEnabled)
    })
  }
  
  private func updatePeopleOcclusion(isEnabled: Bool) {
    guard ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) else { return }
    guard let configuration = session.configuration as? ARWorldTrackingConfiguration else { return }
    
    if configuration.frameSemantics.contains(.personSegmentationWithDepth) {
      configuration.frameSemantics.remove(.personSegmentationWithDepth)
    } else {
      configuration.frameSemantics.insert(.personSegmentationWithDepth)
    }
    
    session.run(configuration)
  }
  
  private func updateObjectOcclusion(isEnabled: Bool) {
    if environment.sceneUnderstanding.options.contains(.occlusion) {
      environment.sceneUnderstanding.options.remove(.occlusion)
    } else {
      environment.sceneUnderstanding.options.insert(.occlusion)
    }
  }
  
  private func updateLidarDebug(isEnabled: Bool) {
    if debugOptions.contains(.showSceneUnderstanding) {
      debugOptions.remove(.showSceneUnderstanding)
    } else {
      debugOptions.insert(.showSceneUnderstanding)
    }
  }
  
  private func updateMultiuser(isEnabled: Bool) {
    
  }
}
