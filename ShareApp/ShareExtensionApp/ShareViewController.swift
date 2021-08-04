//
//  ShareViewController.swift
//  ShareExtensionApp
//
//  Created by Hitesh on 31/07/21.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        let userDefaults = UserDefaults(suiteName: "group.com.developer.ShareApp.ShareExt")
        let checkData = userDefaults?.value(forKey: "CheckData") as? String
        debugPrint("checkData",checkData ?? "Not exist")
        guard let extenstionItem = self.extensionContext?.inputItems.first as? NSExtensionItem else { return }
        print("extenstionItem := ", extenstionItem)
        guard let attachments = extenstionItem.attachments else { return }
        let imageTypeContent = kUTTypeImage as String
        let videoTypeConetent = kUTTypeVideo as String
        
        for provider in attachments {
            if provider.hasItemConformingToTypeIdentifier(imageTypeContent) { // Image Type Data
                provider.loadItem(forTypeIdentifier: imageTypeContent, options: nil) { [weak self] (secureCodingData, error) in
                    print("secureCodingData := ", secureCodingData)
                    var image: UIImage?
                    if let someURl = secureCodingData as? URL {
                        image = UIImage(contentsOfFile: someURl.path)
                    }else if let someImage = secureCodingData as? UIImage {
                        image = someImage
                    }
                    print("imageData Bytes:= ", image)
//                    self?.save(imageData, key: "imageData", value: imageData)
                    self?.completeExtentionRequest()
                }
            } else if provider.hasItemConformingToTypeIdentifier(videoTypeConetent) { // Video Type Data
                provider.loadItem(forTypeIdentifier: videoTypeConetent, options: nil) { [unowned self] (data, error) in
                    guard error == nil else { return }
                    print("secureCodingData := ", data)

                }
            }
        }
        
    }
    
    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    
    
    override func viewDidLoad() {
        guard let items = self.extensionContext?.inputItems else { return }
        print("items := ", items)
    }
    private func completeExtentionRequest() {
        /// This method should call to close this extension app
        self.extensionContext?.completeRequest(returningItems: [], completionHandler: nil)
    }
    /// Save Data in user default
    private func save(_ data: Data, key: String, value: Any) {
      // You must use the userdefaults of an app group, otherwise the main app don't have access to it.
      let userDefaults = UserDefaults(suiteName: "com.developer.ShareApp")
      userDefaults?.set(data, forKey: key)
    }
}
