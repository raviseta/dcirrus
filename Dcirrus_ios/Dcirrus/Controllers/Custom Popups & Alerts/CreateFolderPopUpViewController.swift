//
//  CreateFolderPopUpViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 28/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

protocol TextFieldPopUpDelegate:class {
    func addFolder(_ folderName: String , isFileCreation : Bool)
}

class CreateFolderPopUpViewController: UIViewController {
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    var intialYPosition : CGFloat = 0.0
    var delegate : TextFieldPopUpDelegate?
    var isFileCreation = false
    var popupType : ePopupType = ePopupType.folderCreate
    var currentFolderName: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setUI()
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            self.containerView.frame.origin.y = self.intialYPosition
        }
        if self.popupType == .renameFolder {
            self.nameTextField.text = currentFolderName
        }
    }
    func setUI() {
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 10
        self.addButton.clipsToBounds = true
        self.addButton.layer.cornerRadius = addButton.frame.height / 2
        self.intialYPosition = self.containerView.frame.origin.y
        self.containerView.frame.origin.y = self.view.frame.height
        if self.isFileCreation {
            self.iconImageView.image = UIImage(named: "file_icon")
            self.titleLabel.text = "ENTER FILE NAME"
            self.nameTextField.placeholder = "File name"
        }
        if popupType == ePopupType.folderCreate{
            self.iconImageView.image = UIImage(named: "file_icon")
            self.titleLabel.text = "ENTER FOLDER NAME"
            self.nameTextField.placeholder = "Folder name"
        }
        else if popupType == ePopupType.fileCreate{
            self.iconImageView.image = UIImage(named: "file_icon")
            self.titleLabel.text = "ENTER FILE NAME"
            self.nameTextField.placeholder = "File name"
        }else if popupType == ePopupType.renameFolder{
            self.iconImageView.image = UIImage(named: "file_icon")
            self.titleLabel.text = "RENAME FOLDER"
            self.nameTextField.placeholder = "Folder name"
            addButton.setTitle("RENAME", for: .normal)
        }
    }

    @IBAction func addButtonAction(_ sender: Any) {
        self.dissmissView(isAddAction: true)
    }
    @IBAction func cancelButtonAction(_ sender: Any) {
        self.dissmissView(isAddAction: false)
    }
    func dissmissView(isAddAction : Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.containerView.frame.origin.y = self.view.frame.height
        }) { (_) in
            
            self.dismiss(animated: false) {
                if isAddAction {
                    self.delegate?.addFolder(self.nameTextField.text ?? "", isFileCreation: self.isFileCreation)
                }
            }
        }
    }
}
