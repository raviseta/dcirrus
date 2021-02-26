//
//  SignupView.swift
//  Dcirrus
//
//  Created by Gaadha on 18/09/19.
//  Copyright © 2019 Goodbits. All rights reserved.
//

import UIKit
import Toast_Swift

class SignupView: UIViewController {
    
    
    @IBOutlet weak var m_btnSendRequest: UIButton!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEmail: UITextField!
    @IBOutlet var txtLoginID: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialsettings()
        // Do any additional setup after loading the view.
    }
    

    @IBAction func actionLogin(_ sender: Any) {
        
        self.moveToLogin()
    }
    
    @IBAction func actionLoginasCorparateUser(_ sender: Any) {
        
        self.moveToRegister()
    }
    
    @IBAction func actionsendRequest(_ sender: Any) {
        print("Pressed send button")
        self.view.makeToast("Sign-up request has been sent successfully.\nOur team will get in touch with you soon", duration: 1.5, position: .center)
        
    }
    
    @IBAction func actionLoginViaFb(_ sender: Any) {
        
    }
    
    @IBAction func actionLoginViaGoogle(_ sender: Any) {
        
    }
    
}

extension SignupView{
    
    func initialsettings() {
        self.m_btnSendRequest.layer.cornerRadius = 32
        self.m_btnSendRequest.layer.shadowColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        self.m_btnSendRequest.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.m_btnSendRequest.layer.shadowRadius = 5
        self.m_btnSendRequest.layer.shadowOpacity = 1.0
    }
    
    func moveToLogin() {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    func moveToRegister() {
        
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "RegisterViewid") as? RegisterView
        self.navigationController?.pushViewController(vc!, animated: false)
    }
}
