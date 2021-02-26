//
//  CustomAlertViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 25/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class CustomAlertViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var alertImageView: UIImageView!
    @IBOutlet weak var alertTitleLabel: UILabel!
    @IBOutlet weak var alertMessageLabel: UILabel!
    @IBOutlet weak var alertButton: UIButton!
    var intialYPosition : CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            self.containerView.frame.origin.y = self.intialYPosition
        }
    }
    func setUI() {
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 5
        self.alertButton.clipsToBounds = true
        self.alertButton.layer.cornerRadius = 5
        self.intialYPosition = self.containerView.frame.origin.y
        self.containerView.frame.origin.y = self.view.frame.height
    }
    @IBAction func alertButtonAction(_ sender: Any) {
        self.dismiss(animated: true) {
            
        }
    }
    
}
