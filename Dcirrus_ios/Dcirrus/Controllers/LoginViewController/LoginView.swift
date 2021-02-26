//
//  ViewController.swift
//  Dcirrus
//
//  Created by Gaadha on 17/09/19.
//  Copyright © 2019 Goodbits. All rights reserved.
//

import UIKit
import ObjectMapper

class LoginView: UIViewController {

    var loginViewModel : LoginViewModel!

    @IBOutlet weak var m_btnLogin       : UIButton!
    @IBOutlet weak var m_btnSignup      : UIButton!
    @IBOutlet weak var m_btnCheckbox    : UIImageView!
    @IBOutlet weak var m_btnpasswordvisibility: UIImageView!
    @IBOutlet weak var m_txtfieldPassword: UITextField!

    @IBOutlet var txtUserID: UITextField!
    @IBOutlet var txtBusinessID: UITextField!

    var checkboxFlag  =  0
    var passwordFlag  =  0


    //MARK:- View cycle

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.initialsettings()
        self.setupViewModel()

    }

    func setupViewModel(){
        self.loginViewModel = LoginViewModel()
    }


    //MARK:- Button Actions
    @IBAction func actionBtnViewPassword(_ sender: Any)
    {
        if self.passwordFlag == 0 {

            self.m_btnpasswordvisibility.image = UIImage(named: "ticked_box")
            self.m_txtfieldPassword.isSecureTextEntry = false
            self.passwordFlag = 1
        }
        else {

            self.m_btnpasswordvisibility.image = UIImage(named: "passwordNotVisible_icon")
            self.m_txtfieldPassword.isSecureTextEntry = true
            self.passwordFlag = 0
        }

        //self.logincontroller.setVisibilityOfPassword()
    }

    @IBAction func actionBtnRememberPassword(_ sender: Any)
    {
        if self.checkboxFlag == 0 {

            self.m_btnCheckbox.image = UIImage(named: "ticked_box")
            self.checkboxFlag = 1
        }
        else {

            self.m_btnCheckbox.image = UIImage(named: "box_icon")
            self.checkboxFlag = 0
        }

       // self.logincontroller.savePassword()
    }

    @IBAction func actionSignup(_ sender: Any)
    {
        self.moveToSignup()
       // self.logincontroller.moveToSignupPage()
    }

    @IBAction func actionLogin(_ sender: Any)
    {
        //self.checkValidation()
        self.wsCallLogin()

    }



    @IBAction func actionForgotPassword(_ sender: Any)
    {

        moveToForgotPasswordPage()
    }

    //MARK:- User define functions
    func checkValidation(){
        self.view.endEditing(true)
        if let loginID = self.txtUserID.text, loginID.isBlank == true {
            self.view.makeToast("Enter your UserID", duration: 1.5, position: .center)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                self.txtUserID.becomeFirstResponder()
            })
            return
        }else if !(txtUserID.text!.isValidEmail){
            self.view.makeToast("Enter Valid Email ID", duration: 1.5, position: .center)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                self.txtUserID.becomeFirstResponder()
            })
            return
        }
        if let password = self.m_txtfieldPassword.text, password.isBlank == true {
            self.view.makeToast("Enter your password", duration: 1.5, position: .center)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                self.m_txtfieldPassword.becomeFirstResponder()
            })
            return
        }
        if let businessID = self.txtBusinessID.text, businessID.isBlank == true {
            self.view.makeToast("Enter your businessID", duration: 1.5, position: .center)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.4, execute: {
                self.txtBusinessID.becomeFirstResponder()
            })
            return
        }
    }

}

extension LoginView {

    func moveToForgotPasswordPage() {

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgotPasswordViewid") as? ForgotPasswordView
        self.navigationController?.pushViewController(vc!, animated: false)
    }

    func initialsettings() {
        self.m_btnLogin.layer.cornerRadius = 32
        self.m_btnLogin.layer.shadowColor = #colorLiteral(red: 0.6666666667, green: 0.6666666667, blue: 0.6666666667, alpha: 1)
        self.m_btnLogin.layer.shadowOffset = CGSize(width: 5, height: 5)
        self.m_btnLogin.layer.shadowRadius = 5
        self.m_btnLogin.layer.shadowOpacity = 1.0
        
        self.txtUserID.text = "ext@dcirrus.co.in"
        self.m_txtfieldPassword.text = "Test@1234"
        self.txtBusinessID.text = "0020379"
        
        /*
         ext@dcirrus.co.in
         Test@1234
         0020379
        */
    }

    func moveToSignup() {

        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignupViewid") as? SignupView
        self.navigationController?.pushViewController(vc!, animated: false)
    }
}
//MARK:- API Call
extension LoginView {
    func wsCallLogin(){

      //  let deviceID = UUID.init().uuidString
        let deviceID = "EXTDCIRRUSCOIN"


        var parameter = Dictionary<String,Any>()


        let userValidate = UserValidate()

        userValidate.userName = self.txtUserID.text!
        userValidate.password = self.m_txtfieldPassword.text!
        userValidate.lawFirmNumber = "\(self.txtBusinessID.text!)"
        userValidate.deviceId = deviceID
        parameter["userValidateDto"] = userValidate.toDictionary()


        let deviceInfo = DeviceInfo()

        deviceInfo.lawFirmNumber = "\(self.txtBusinessID.text!)"
        deviceInfo.deviceId  = deviceID
        deviceInfo.loginId = self.txtUserID.text!
        deviceInfo.remoteAddress = getIPAddress() ?? ""
        deviceInfo.deviceType = "iOS"
        deviceInfo.deviceName  = "\(UIDevice.current.name)"
        deviceInfo.remoteAddressV4 = getIPAddress() ?? ""
        deviceInfo.geoLocation  = ""
        deviceInfo.deviceToken  = deviceID

        parameter["deviceDto"] = deviceInfo.toDictionary()

        _ = APIManager.shared.requestPostJSON(url: eAppURL.login, parameters: parameter, isShowIndicator: true, completionHandler: { (result) in
            switch result {

            case .success(let dicData):
                if let objResponse = dicData as? Dictionary<String,Any> {

                    var statusCode: Int = 0
                    if let statusCodel = objResponse[APIKey.messageCode] as? Int {
                        statusCode = statusCodel
                    }

                    switch statusCode {
                    case 201:
                        let objUser: LoginResponse = Mapper().map(JSON: objResponse)!
                        print(objUser)
                        if let token = objUser.objectD?.token{
                            Constants.token = token
                            setValueInPreference(forKey: Preference.token, value: token)
                            setValueInPreference(forKey: Preference.logedInUser, value: objUser.toJSON())
                        }
                        self.loginViewModel.loginaction()
                        break
                    case 433 : break
                    case 419 :showInfoMessage(messsage: errorMessage.login_messages_userapprovalrequest.rawValue)
                        break
                    case 421 :showInfoMessage(messsage: errorMessage.login_messages_deviceblockedexceedloginBussiness.rawValue)
                        break
                    case 422 :showInfoMessage(messsage: errorMessage.login_messages_userapprovalrequest.rawValue)
                        break
                    case 428 :showInfoMessage(messsage: errorMessage.login_messages_corporateExpiredUser.rawValue)
                        break
                    case 427 :showInfoMessage(messsage: errorMessage.login_messages_deviceblockedexceedloginIndividual.rawValue)
                        break
                    case 416,417 :showInfoMessage(messsage: errorMessage.login_messages_deviceblocked.rawValue)
                        break
                    case 418 :showInfoMessage(messsage: errorMessage.login_messages_deviceblockedbyuser.rawValue)
                        break
                    case 423 :showInfoMessage(messsage: errorMessage.login_messages_invalidip.rawValue)
                        break
                    case 415,420 :showInfoMessage(messsage: errorMessage.login_messages_userblocked.rawValue)
                        break
                    case 429 :showInfoMessage(messsage: errorMessage.login_messages_userfirstblocked.rawValue)
                        break
                    case 424 :showInfoMessage(messsage: errorMessage.login_messages_captchamismatch.rawValue)
                        break
                    case 425 :showInfoMessage(messsage: errorMessage.login_messages_invalidcredentials.rawValue)
                        break
                    case 431 :showInfoMessage(messsage: errorMessage.login_messages_OTPmismatch.rawValue)
                        break
                    case 432 :showInfoMessage(messsage: errorMessage.login_messages_corpsetupincomplete.rawValue)
                        break
                    case 500...599:
                        if let message = objResponse["message"] as? String {
                            if message.isBlank == false {
                               showInfoMessage(messsage: message)
                            }else {
                                showInfoMessage(messsage: "Internal Server Error server error")
                            }
                        }
                    default:
                        if let message = objResponse["message"] as? String {
                            if message.isBlank == false {
                               showInfoMessage(messsage: message)
                            }else {
                                showInfoMessage(messsage: "Internal Server Error server error")
                            }
                        }
                        break
                    }


                }
            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        })
    }
}
