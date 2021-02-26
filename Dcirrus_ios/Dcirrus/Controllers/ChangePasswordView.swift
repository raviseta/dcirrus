//
//  ChangePasswordView.swift
//  Dcirrus
//
//  Created by Gaadha on 18/09/19.
//  Copyright © 2019 Goodbits. All rights reserved.
//

import UIKit

class ChangePasswordView: UIViewController {

    @IBOutlet weak var m_btnpasswordvisibility: UIButton!
    @IBOutlet weak var m_imgpasswordvisibility: UIImageView!
    @IBOutlet weak var m_btnDone: UIButton!
    @IBOutlet weak var m_txtfieldPassword: UITextField!
    @IBOutlet weak var m_txtfieldCurrentPassword: UITextField!
    
    var passwordFlag  =  0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.m_btnDone.clipsToBounds = true
        self.m_btnDone.layer.cornerRadius = m_btnDone.frame.height / 2
    }
    
    @IBAction func actionChangePasswordvisibility(_ sender: Any) {
        
        if self.passwordFlag == 0 {
            
            self.m_imgpasswordvisibility.image = UIImage(named: "ticked_box")
            self.m_txtfieldPassword.isSecureTextEntry = false
            self.passwordFlag = 1
        }
        else {
            
            self.m_imgpasswordvisibility.image = UIImage(named: "passwordNotVisible_icon")
            self.m_txtfieldPassword.isSecureTextEntry = true
            self.passwordFlag = 0
        }
    }
    
    @IBAction func actionDone(_ sender: Any) {
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChangePasswordView {
    
    func initialsettings(){
        self.m_btnDone.layer.cornerRadius = 32
        self.m_btnDone.layer.shadowColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        self.m_btnDone.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.m_btnDone.layer.shadowRadius = 5
        self.m_btnDone.layer.shadowOpacity = 1.0
    }
}
