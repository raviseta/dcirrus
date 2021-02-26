//
//  CreateFilePopUpViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 31/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

protocol FileCreationPopUpDelegate:class {
    func showFileNamePopUp()
}
class CreateFilePopUpViewController: UIViewController {
   
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var browseButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var intialYPosition : CGFloat = 0.0
    var delegate : FileCreationPopUpDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            self.containerView.frame.origin.y = self.intialYPosition
        }
    }
    func setUI() {
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 10
        self.browseButton.clipsToBounds = true
        self.browseButton.layer.cornerRadius = browseButton.frame.height / 2
        self.intialYPosition = self.containerView.frame.origin.y
        self.containerView.frame.origin.y = self.view.frame.height
    }
    @IBAction func browseButtonAction(_ sender: Any) {
        self.dissmissView(isBrowseAction: true)
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dissmissView()
    }
    func dissmissView(isBrowseAction : Bool = false) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.containerView.frame.origin.y = self.view.frame.height
        }) { (_) in
            self.dismiss(animated: false) {
                if isBrowseAction {
                    self.delegate?.showFileNamePopUp()
                }
            }
        }
    }
    
}
