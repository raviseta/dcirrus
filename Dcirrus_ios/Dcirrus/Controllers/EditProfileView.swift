//
//  EditProfileView.swift
//  Dcirrus
//
//  Created by Gaadha on 19/09/19.
//  Copyright © 2019 Goodbits. All rights reserved.
//

import UIKit

class EditProfileView: UIViewController {
    
    
    @IBOutlet weak var m_btnDone: UIButton!
    @IBOutlet var txtFirstName: UITextField!
    @IBOutlet var txtLastName: UITextField!
    @IBOutlet var txtLoginID: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtMobileNumber: UITextField!
    var objProfile : ProfileDataResponse!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsettings()
        // Do any additional setup after loading the view.
        self.title = "Edit Profile"
        self.txtFirstName.text = objProfile.object?.contactDto?.firstName
        self.txtLastName.text = objProfile.object?.contactDto?.lastName
        self.txtEmail.text = objProfile.object?.contactDto?.email
        self.txtMobileNumber.text = objProfile.object?.contactDto?.contactPhoneList
        self.txtLoginID.text = objProfile.object?.contactDto?.loginID
    }
    
    @IBAction func actionDone(_ sender: Any) {
        self.view.makeToast("Profile updated successfully.", duration: 1.5, position: .center)
    }
    
    @IBAction func actionBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
}

extension EditProfileView {
    
    func initialsettings() {
        self.m_btnDone.layer.cornerRadius = 32
        self.m_btnDone.layer.shadowColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        self.m_btnDone.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.m_btnDone.layer.shadowRadius = 5
        self.m_btnDone.layer.shadowOpacity = 1.0
    }
    
}
