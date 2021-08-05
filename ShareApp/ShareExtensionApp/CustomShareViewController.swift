//
//  CustomShareViewController.swift
//  ShareExtensionApp
//
//  Created by Hitesh on 05/08/21.
//

import UIKit

class CustomShareViewController: UIViewController {

    private var appURLString = "ShareExtension101://home?url="

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @objc func openURL(_ url:URL) -> Bool {
        var responder : UIResponder? = self
        while responder != nil {
            if let application = responder as? UIApplication {
                return application.perform(#selector(openURL(_:)), with: url) != nil
            }
            responder = responder?.next
        }
        
        return false
    }
    
    private func hideExtensionWithCompletionHandler(completion:@escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.20, animations: {

            self.navigationController!.view.transform = CGAffineTransform(translationX: 0, y: self.navigationController!.view.frame.size.height)
        }, completion: completion)
    }
    
    private func openMainApp() {
        guard let url = URL(string: self.appURLString) else { return }
        _ = self.openURL(url)
    }
    
    //MARK: - IBAction
    @IBAction func onBtnSaveAction(_ sender: Any) {
        hideExtensionWithCompletionHandler { (completion) in
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: { _ in
                self.openMainApp()
            })
        }
    }
    @IBAction func onBtnCancelAction(_ sender: Any) {
        hideExtensionWithCompletionHandler { (completion) in
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
        }
    }
    
}
