//
//  CustomShareViewController.swift
//  ShareExtensionApp
//
//  Created by Hitesh on 05/08/21.
//

import UIKit

class CustomShareViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    
    
    func hideExtensionWithCompletionHandler(completion:@escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.20, animations: {

            self.navigationController!.view.transform = CGAffineTransform(translationX: 0, y: self.navigationController!.view.frame.size.height)
        }, completion: completion)
    }
    
    //MARK: - IBAction
    @IBAction func onBtnCancelAction(_ sender: Any) {
        hideExtensionWithCompletionHandler { (completion) in
            self.extensionContext?.completeRequest(returningItems: nil, completionHandler: nil)
        }
    }
    
}
