//
//  ShareNavigationController.swift
//  ShareExtensionApp
//
//  Created by Hitesh on 05/08/21.
//

import UIKit
@objc(ShareNavigationController)

class ShareNavigationController: UINavigationController {

    init() {
        let vc = UIStoryboard(name: "MainInterface", bundle: nil).instantiateViewController(withIdentifier: "CustomShareViewController") as UIViewController
        super.init(rootViewController: vc)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.transform = CGAffineTransform(translationX: 0, y: self.view.frame.size.height)
        UIView.animate(withDuration: 0.25) {
            self.view.transform = .identity
        }
    }
}
