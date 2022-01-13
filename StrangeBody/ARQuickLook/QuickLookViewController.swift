import UIKit
import QuickLook
import SwiftUI

struct QuickLookContainer: UIViewControllerRepresentable {
  func makeUIViewController(context: Context) -> QuickLookViewConrtoller {
    return QuickLookViewConrtoller()
  }
  
  func updateUIViewController(_ uiViewController: QuickLookViewConrtoller, context: Context) {
  }
}

class QuickLookViewConrtoller: UIViewController {
  
  private var modelIndex = 0
  private let models = ["Pig", "Teapot", "Gramophone"]
  
  let tableView = UITableView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.addSubview(tableView)
    tableView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      tableView.topAnchor.constraint(equalTo: view.topAnchor),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
    tableView.delegate = self
    tableView.dataSource = self
  }
  
}

extension QuickLookViewConrtoller: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return models.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
    var content = cell.defaultContentConfiguration()
    content.text = models[indexPath.row]
    cell.contentConfiguration = content
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    modelIndex = indexPath.row
    let previewController = QLPreviewController()
    previewController.delegate = self
    previewController.dataSource = self
    present(previewController, animated: true)
  }
}

extension QuickLookViewConrtoller: QLPreviewControllerDelegate, QLPreviewControllerDataSource {
  func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
    return 1
  }
  
  func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
    let url = Bundle.main.url(forResource: models[modelIndex], withExtension: "usdz")
    return url! as QLPreviewItem
  }
}
