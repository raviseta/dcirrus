//
//  UploadAlertViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 01/04/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit


class UploadAlertViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var uploadingLabel: UILabel!
    @IBOutlet weak var progressView: UIProgressView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUI()
        self.progressView.setProgress(0.0, animated: false)
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        }) { (_) in
            self.showProgressbarAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.3) {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    func setUI() {
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 50
        
    }
    func showProgressbarAnimation() {
        self.progressView.setProgress(0.0, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.progressView.setProgress(1.0, animated: true)
        }

        
//        self.progressView.layer.sublayers?.forEach { $0.removeAllAnimations() }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            // set progressView to 0%, with animated set to false
//            self.progressView.setProgress(1.0, animated: false)
//            // 10-second animation changing from 100% to 0%
//            UIView.animate(withDuration: 3, delay: 0, options: [], animations: { [unowned self] in
//                self.progressView.layoutIfNeeded()
//            })
//        }
    }
}
