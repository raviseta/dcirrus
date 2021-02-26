//
//  ProfileViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 26/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    enum SettingsOptions : Int {
        case changePassword
        case notificationUpdates
        case termsAndConditions
        case privacyAndPolicy
        case signupAsDiffrentUser
        case helpAndSupport
        case rowCount
    }
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var optionsTableView: UITableView!
    
    var profileViewModel = ProfileViewModel()
    var objProfile : ProfileDataResponse! {
        didSet{
            if objProfile != nil {
                var finalName = ""
                if let fn = objProfile.object?.contactDto?.firstName ,let lastname =    objProfile.object?.contactDto?.lastName {
                    finalName = "\(fn) \(lastname)"
                }
                
                self.emailLabel.text = objProfile.object?.contactDto?.email
                self.phoneNumberLabel.text = objProfile.object?.contactDto?.contactPhoneList
                self.nameLabel.text = finalName
            
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileViewModel.wsGetProfileData { (result) in
            switch(result){
            case .success(let profileResponse):
                self.objProfile = profileResponse
                break
            case .failure(_): break
                
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setUI()
    }
    func setUI() {
        self.title = "Profile"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
//        let titleLabel = Utilities.titleLabel()
//        titleLabel.text = "Profile"
//        navigationItem.titleView = titleLabel
        self.addRightBarButton()
    }
    func addRightBarButton() {
           let button = UIButton(type: .custom)
           button.setImage(UIImage(named: "more_icon"), for: .normal)
           button.addTarget(self, action: #selector(moreButtonPressed), for: .touchUpInside)
           button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
           let barButton = UIBarButtonItem(customView: button)
           self.navigationItem.rightBarButtonItem = barButton
       }
    func showTermsAndConditionsScreen() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TermsAndConditionsViewController")
        self.navigationController?.pushViewController (controller, animated: true)
    }
    func showChangePasswordScreen() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChangePasswordView")
        self.navigationController?.pushViewController (controller, animated: true)
    }
    func showEditProfileScreen() {
        if let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EditProfileView") as? EditProfileView{
            controller.objProfile = objProfile
            self.navigationController?.pushViewController (controller, animated: true)
        }
    }
    
    func showLogoutAction() {
        let alertController = UIAlertController(title: "", message: "Are you sure you want to logout from DCirrus?", preferredStyle: .alert)

        // Create the actions
        let okAction = UIAlertAction(title: "YES", style: UIAlertAction.Style.default) {
            UIAlertAction in
            
            removeValueFromPreference(forKey: Preference.token)
            removeValueFromPreference(forKey: Preference.logedInUser)
            
            let app = UIApplication.shared.delegate as! AppDelegate
            app.logout()
        }
        let cancelAction = UIAlertAction(title: "NO", style: UIAlertAction.Style.cancel) {
            UIAlertAction in

        }

        // Add the actions
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)

        // Present the controller
        self.present(alertController, animated: true, completion: nil)
    }
    @objc func moreButtonPressed() {
        print("moreButtonPressed")
        let alert = UIAlertController(title: "Please select an option", message: "", preferredStyle: .actionSheet)

        alert.addAction(UIAlertAction(title: "Edit Profile", style: .default , handler:{ (UIAlertAction)in
            self.showEditProfileScreen()
        }))

        alert.addAction(UIAlertAction(title: "Logout", style: .default , handler:{ (UIAlertAction)in
            
            self.showLogoutAction()
        }))

        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel , handler:{ (UIAlertAction)in
            
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}
extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingsOptions.rowCount.rawValue
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case SettingsOptions.notificationUpdates.rawValue:
            return self.setupSwitchTableViewCell(indexPath: indexPath)
        default:
            return self.setupLabelTableViewCell(indexPath: indexPath)
        }
    }
    func setupLabelTableViewCell(indexPath : IndexPath) -> UITableViewCell {
        if let cell = optionsTableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.identifier, for: indexPath) as? SettingsTableViewCell {
            cell.selectionStyle = .none
            cell.nameLabel.text = getSettingsLabelNameAndIcon(index: indexPath.row).0
            cell.iconImageView.image = getSettingsLabelNameAndIcon(index: indexPath.row).1
            return cell
        }
        return UITableViewCell()
    }
    func setupSwitchTableViewCell(indexPath : IndexPath) -> UITableViewCell {
        if let cell = optionsTableView.dequeueReusableCell(withIdentifier: SettingsSwitchTableViewCell.identifier, for: indexPath) as? SettingsSwitchTableViewCell {
            cell.selectionStyle = .none
            cell.nameLabel.text = getSettingsLabelNameAndIcon(index: indexPath.row).0
            cell.iconImageView.image = getSettingsLabelNameAndIcon(index: indexPath.row).1
            return cell
        }
        return UITableViewCell()
    }
    func getSettingsLabelNameAndIcon(index : Int) -> (String , UIImage?) {
        let nameArray = ["Change password" , "Notification updates" , "Terms & Conditions" , "Privacy & Policy" , "Signup as diffrent user" , "Help and Support"]
        let iconNameArray = ["lock_icon" , "notification_icon" , "termsndCondi" , "privacy_policy" , "add_account" , "help_dummy"]
        return (nameArray[index] , UIImage(named: iconNameArray[index]))
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       switch indexPath.row {
        case SettingsOptions.termsAndConditions.rawValue:
            self.showTermsAndConditionsScreen()
        case SettingsOptions.changePassword.rawValue:
            self.showChangePasswordScreen()
        default:
            return
        }
    }
}
class SettingsTableViewCell : UITableViewCell {
    static let identifier = "SettingsTableViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
}
class SettingsSwitchTableViewCell : UITableViewCell {
    static let identifier = "SettingsSwitchTableViewCell"
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var onOffSwitch: UISwitch!
}
