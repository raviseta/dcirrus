//
//  AddContactPopUpViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 30/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit


class AddContactPopUpViewController: UIViewController {

   

    @IBOutlet weak var containerView : UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var mobileNoTextField: UITextField!
    @IBOutlet weak var phoneSecurityButton: UIButton!
    @IBOutlet weak var emailSecurityButton: UIButton!
    @IBOutlet weak var noSecurityButton: UIButton!
    @IBOutlet weak var addMoreButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    var intialYPosition : CGFloat = 0.0

    var callback: ((EmailID?)->())?
    var phoneSecurity : Int = 0
    var emailSecurity : Int = 0
    var noSecurity : Int = 0
    
    var emailList = [EmailID]()


    //MARK:- View cycle
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
        self.containerView.layer.cornerRadius = 20
        self.addMoreButton.clipsToBounds = true
        self.addMoreButton.layer.cornerRadius = addMoreButton.frame.height / 2
        self.intialYPosition = self.containerView.frame.origin.y
        self.containerView.frame.origin.y = self.view.frame.height
        self.noSecurityButton.setImage(#imageLiteral(resourceName: "ticked_box") , for: .normal)
    }

    func dissmissView(isAddAction : Bool) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.containerView.frame.origin.y = self.view.frame.height
        }) { (_) in
            self.dismiss(animated: false, completion: nil)
        }
    }

    //MARK:- Button Actions

    @IBAction func closeButtonAction(_ sender: Any) {
        self.dissmissView(isAddAction: false)
    }

    @IBAction func addMoreButtonAction(_ sender: Any) {
        self.view.endEditing(true)
        if let email = self.emailTextField.text, email.isBlank == true {
            showInfoMessage(messsage: "Enter email address!")
            return
        }
        else if !(self.emailTextField.text!.isValidEmail){
            showInfoMessage(messsage: "Enter Valid Email ID")
            return
        }
        if (self.phoneSecurity != 0){
            if let phone = self.mobileNoTextField.text, phone.isBlank == true {
                showInfoMessage(messsage: "Enter mobile number!")
                return
            }
        }
        
        if self.checkEmailExist(){
            return
        }
        
        let email = EmailID()
        email.emailId = self.emailTextField.text ?? ""
        email.phoneNumber = self.mobileNoTextField.text ?? ""
        email.isKeyEmail = self.emailSecurity
        email.isKeySMS = self.phoneSecurity
        emailList.append(email)
        self.callback?(email)
        self.emailTextField.text = ""
        self.mobileNoTextField.text = ""
        self.emailTextField.becomeFirstResponder()
        self.phoneSecurity = 0
        self.noSecurityButton.setImage(#imageLiteral(resourceName: "ticked_box") , for: .normal)
        
    }

    @IBAction func saveButtonAction(_ sender: Any) {
        if let email = self.emailTextField.text, email.isBlank == true {
            showInfoMessage(messsage: "Enter email address!")
            return
        }
        
        if self.phoneSecurity != 0 {
            if let phone = self.mobileNoTextField.text, phone.isBlank == true {
                showInfoMessage(messsage: "Enter mobile number!")
                return
            }
        }
        
        if self.checkEmailExist(){
            return
        }
        
        
        self.dismiss(animated: false) {
            let email = EmailID()
            email.emailId = self.emailTextField.text ?? ""
            email.phoneNumber = self.mobileNoTextField.text ?? ""
            email.isKeyEmail = self.emailSecurity
            email.isKeySMS = self.phoneSecurity
            self.emailList.append(email)
            self.callback?(email)
        }
        
    }

    @IBAction func phoneSecurityButtonAction(_ sender: Any) {

        if self.phoneSecurity == 1{
           self.phoneSecurityButton.setImage(#imageLiteral(resourceName: "box_icon") , for: .normal)
            self.phoneSecurity = 0
        }else{
            self.phoneSecurityButton.setImage(#imageLiteral(resourceName: "ticked_box") , for: .normal)
            self.phoneSecurity = 1
            self.noSecurityButton.setImage(#imageLiteral(resourceName: "box_icon"), for: .normal)
        }
    }

    @IBAction func emailSecurityButtonAction(_ sender: Any) {
        if self.emailSecurity == 1{
            self.emailSecurityButton.setImage(#imageLiteral(resourceName: "box_icon") , for: .normal)
            self.emailSecurity = 0
        }else{
            self.emailSecurityButton.setImage(#imageLiteral(resourceName: "ticked_box") , for: .normal)
            self.emailSecurity = 1
            self.noSecurityButton.setImage(#imageLiteral(resourceName: "box_icon"), for: .normal)
        }

    }

    @IBAction func noSecurityButtonAction(_ sender: Any) {
        if self.noSecurity == 1{
           self.noSecurityButton.setImage(#imageLiteral(resourceName: "box_icon"), for: .normal)
            self.noSecurity = 0
        }else{
            self.noSecurity = 1
            self.noSecurityButton.setImage(#imageLiteral(resourceName: "ticked_box") , for: .normal)

        }
        self.phoneSecurity = 0
        self.emailSecurity = 0
        self.emailSecurityButton.setImage(#imageLiteral(resourceName: "box_icon") , for: .normal)
        self.phoneSecurityButton.setImage(#imageLiteral(resourceName: "box_icon") , for: .normal)


    }

    func checkEmailExist()->Bool{
        let filter = emailList.filter { (obj) -> Bool in
            return obj.emailId == self.emailTextField.text
        }
        if filter.count > 0{
            showInfoMessage(messsage: "Email already added.")
            return true
        }
        return false
    }
    
}
