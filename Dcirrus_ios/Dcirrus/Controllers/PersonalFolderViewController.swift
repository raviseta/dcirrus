//
//  PersonalFolderViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 31/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import SwipeCellKit
import ObjectMapper

class PersonalFolderViewController: UIViewController {

    @IBOutlet weak var actionButtonsContainerView: UIView!
    @IBOutlet weak var actionFolderButton: UIButton!
    @IBOutlet weak var actionFileButton: UIButton!
    @IBOutlet weak var listingCollectionView: UICollectionView!
    var activeViewType = FolderViewType.list
    var folderNameArray = ["Documents 1" , "Documents 2"]
    var arrFolder = [DataObject]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.setUI()
        self.wsCallGetPersonalFolders()
    }

    func setUI() {
        addSearchButton()
        let titleLabel = Utilities.titleLabel()
        titleLabel.text = "Personal"
        navigationItem.titleView = titleLabel
        self.actionFolderButton.clipsToBounds = true
        self.actionFolderButton.layer.cornerRadius = 15
        self.actionFileButton.clipsToBounds = true
        self.actionFileButton.layer.cornerRadius = 15
        self.showHideAddButtonActions(needToHide: true)
    }
    func addSearchButton() {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "search"), for: .normal)
        button.addTarget(self, action: #selector(searchButtonPressed), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 51)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.rightBarButtonItem = barButton
    }
    func addSearchBar() {
        let searchBar = UISearchBar()
        searchBar.sizeToFit()
        searchBar.delegate = self
        navigationItem.titleView = searchBar
        searchBar.becomeFirstResponder()
    }
    func showHideAddButtonActions(needToHide : Bool) {
        self.actionFolderButton.isHidden = needToHide
        self.actionFileButton.isHidden = needToHide
        self.actionButtonsContainerView.isHidden = needToHide
    }
    @objc func searchButtonPressed() {
        print("searchButtonPressed")
        self.navigationItem.rightBarButtonItem = nil
        self.addSearchBar()
    }
    @IBAction func changeViewTypeButtonAction(_ sender: UIButton) {

        let buttonImage = self.activeViewType == FolderViewType.list ? "moreitems_icon" : "more_dataroom"
        self.activeViewType = self.activeViewType == FolderViewType.list ? FolderViewType.grid : FolderViewType.list
        sender.setImage(UIImage(named: buttonImage), for: .normal)
        self.listingCollectionView.reloadData()
    }
    @IBAction func addButtonAction(_ sender: Any) {
        self.showHideAddButtonActions(needToHide: !self.actionButtonsContainerView.isHidden)
    }
    @IBAction func addFileButtonAction(_ sender: Any) {
        self.showHideAddButtonActions(needToHide: true)
        self.showAddFilePopUp()
    }
    @IBAction func addFolderButtonAction(_ sender: Any) {
        self.showHideAddButtonActions(needToHide: true)
        showFolderCreationPopUp()
    }
    func showFolderCreationPopUp(isFileCreation : Bool = false) {
        let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateFolderPopUpViewController") as! CreateFolderPopUpViewController
        alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        alertView.isFileCreation = isFileCreation
        alertView.delegate = self
        self.present(alertView, animated: false) {

        }
    }
    func showAddFilePopUp() {
        let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateFilePopUpViewController") as! CreateFilePopUpViewController
        alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        alertView.delegate = self
        self.present(alertView, animated: false) {

        }
    }
    func showUploadingAlert() {
        let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UploadAlertViewController") as! UploadAlertViewController
        alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        self.present(alertView, animated: false) {

        }
    }

}
extension PersonalFolderViewController : TextFieldPopUpDelegate {
    func addFolder(_ folderName: String , isFileCreation : Bool) {
        if isFileCreation {
            self.showUploadingAlert()
        } else {
            if folderName != "" {
                self.folderNameArray.append(folderName)
                listingCollectionView.reloadData()
            }
        }

    }
}
extension PersonalFolderViewController : FileCreationPopUpDelegate {
    func showFileNamePopUp() {
        self.showFolderCreationPopUp(isFileCreation: true)
    }
}
extension PersonalFolderViewController : UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.removeFromSuperview()
        setUI()
    }
}
extension PersonalFolderViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.arrFolder.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch activeViewType {
        case .list:

            return CGSize(width: collectionView.frame.width, height: 50)
        case .grid:
            let width = (collectionView.frame.width / 2) - 20
            return CGSize(width: width, height: 150)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch activeViewType {
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folderListCollectionViewCell", for: indexPath) as? folderListCollectionViewCell
            let objData =  self.arrFolder[indexPath.row]
            cell?.delegate = self
            cell?.nameLabel.text = objData.folderNM
            cell?.contentLabel.text = String("\(objData.noOfFiles) Files")
            return cell ?? UICollectionViewCell()
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folderGridCollectionViewCell", for: indexPath) as? folderGridCollectionViewCell
            let objData =  self.arrFolder[indexPath.row]
            cell?.nameLabel.text = objData.folderNM
            cell?.contentLabel.text = String("\(objData.noOfFiles) Files")
            return cell ?? UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let personalFileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonalFileViewController") as? PersonalFileViewController {
            self.navigationController?.pushViewController(personalFileVC, animated: true)
        }
    }
}
extension PersonalFolderViewController : SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }

        return [self.getSwipeButton(title: "Delete", imageName: "delete_white") , self.getSwipeButton(title: "Download", imageName: "download_white") , self.getSwipeButton(title: "User permission", imageName: "permission") , self.getSwipeButton(title: "Share", imageName: "share_white"),self.getSwipeButton(title: "Rename", imageName: "delete_white")]
    }
    func getSwipeButton(title : String , imageName : String , bgColor : String = "5AB8EE")-> SwipeAction {
        let deleteAction = SwipeAction(style: .default, title: title) { action, indexPath in
            // handle action by updating model with deletion
        }
        // customize the action appearance
        deleteAction.image = UIImage(named: imageName)
        deleteAction.font =  UIFont(name: "Helvetica", size: 10.0)!
        deleteAction.backgroundColor = UIColor.hexStringToUIColor(hex:bgColor)
        return deleteAction
    }
}

extension PersonalFolderViewController {
    func wsCallGetPersonalFolders(){
        _ = APIManager.shared.requestGetJSON(url: eAppURL.fetchAllAdmFolderListResponse, parameters: [:], isShowIndicator: true, completionHandler: { (result) in
            switch result {

            case .success(let dicData):
                if let objResponse = dicData as? Dictionary<String,Any> {

                    var statusCode: Int = 0
                    if let statusCodel = objResponse[APIKey.messageCode] as? Int {
                        statusCode = statusCodel
                    }

                    switch statusCode {
                    case 200...299:
                        let objUser: GetRootFolders = Mapper().map(JSON: objResponse)!
                        print(objUser)
                        self.arrFolder.removeAll()
                        objUser.object?.forEach({ (folderObject) in
                            print("folder objects",folderObject)
                            self.arrFolder.append(folderObject)
                        })
                        self.listingCollectionView.reloadData()
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
