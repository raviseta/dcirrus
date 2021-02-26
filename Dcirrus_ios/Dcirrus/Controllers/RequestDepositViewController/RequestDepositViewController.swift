//
//  RequestDepositViewController.swift
//  Dcirrus
//
//  Created by raviseta on 10/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import UIKit

class RequestDepositViewController: UIViewController {

    enum ShareScreenFields : Int {
        case contact
        case subject
        case content
        case options
        case send
        case share
        case rowCount
    }
    
    @IBOutlet weak var tblDownload: UITableView!
    var objEmailData = EmailID()
    var objFolder : DataObject!
    var receiver = Receiver(arrEmailId: Array<EmailID>())
    var strTextView : String = ""
    var strSubject : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.navigationItem.title = "Request Deposit"
        self.tblDownload.tableFooterView = UIView()
    }
    func showAddContactPopUp() {
        let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddContactPopUpViewController") as! AddContactPopUpViewController
        alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        alertView.callback = { objData in
            if let objEmail = objData{
                self.receiver.arrEmailId.append(objEmail)
                self.tblDownload.reloadData()
            }
        }
        alertView.emailList = self.receiver.arrEmailId

        self.present(alertView, animated: false, completion: nil)
    }
    
    @objc func addButtonAction(_ sender : UIButton) {
        self.showAddContactPopUp()
    }
    
    @objc func btnSendAction(_ sender : UIButton){
        self.wsCallDownload()
    }
    
    func wsCallDownload(){

        var arrayOfEmail = Array<Dictionary<String,Any>>()

        for objEmailId  in self.receiver.arrEmailId {
            arrayOfEmail.append(objEmailId.toDictionary())
        }
        
        let requestDepo = RequestDeposit()

        requestDepo.folderId  = "\(objFolder.folderID)"
        requestDepo.serverURL = "https://dcirrus.co.in/api.acms"
        requestDepo.folderType =  "S"
        requestDepo.message = strTextView
        requestDepo.subject = self.strSubject
        requestDepo.userName  = objLogedInUser.objectD?.name ?? ""
        
        requestDepo.emailIds = arrayOfEmail

        _ = APIManager.shared.requestPostJSON(url: eAppURL.admInboundShareURLsServiceAfter, parameters: requestDepo.toDictionary(), isShowIndicator: true, completionHandler: { (result) in
                switch result {

                case .success(let dicData):
                    if let objResponse = dicData as? Dictionary<String,Any> {
                        print(objResponse)
                    }

                case .failure(let error):
                    showInfoMessage(messsage: error.localizedDescription)
                }
            })
    }
    
}
extension RequestDepositViewController :  UITableViewDataSource , UITableViewDelegate {
    //tableView Delegate and Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if receiver.arrEmailId.count > 0 {
            if receiver.isExpand == true {
                return ShareScreenFields.rowCount.rawValue + 1 + receiver.arrEmailId.count
            }else {
                return ShareScreenFields.rowCount.rawValue + 1
            }
        }else {
            return ShareScreenFields.rowCount.rawValue
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if receiver.arrEmailId.count > 0 {
            
            
            if indexPath.row == 0 {
                return self.configureContactCell(indexPath: indexPath)
            }
            if receiver.isExpand == true {
                if indexPath.row == 1 {
                    
                    let cell = self.tblDownload.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
                    cell.nameLabel.text = "Receiver List"
                    cell.removeButton.isHidden = true
                    return cell
                }else {
                    let totalEmail = receiver.arrEmailId.count
                    let index = indexPath.row - 2
                    if index < totalEmail {
                        
                        let cell = self.tblDownload.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
                        cell.nameLabel.text = receiver.arrEmailId[index].emailId
                        cell.removeButton.isHidden = false
                        cell.removeButton.isUserInteractionEnabled = true
                        cell.removeButton.onTap.handle { (tap) in
                            if tap.state == .ended {
                                self.receiver.arrEmailId.remove(at: index)
                                self.tblDownload.reloadData()
                            }
                        }
                        
                        
                        return cell
                    }else if index == totalEmail {
                        let cell = self.tblDownload.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
                        cell.nameLabel.text = "Subject"
                        cell.addButton.isHidden = true
                        cell.backgroundColor = UIColor.white
                        
                        
                        return cell
                    }else if index == totalEmail + 1 {
                        return self.configureContentCell(indexPath: indexPath)
                    }else if index == totalEmail + 2 {
                        return self.configureOptionsCell(indexPath: indexPath)
                    }else if index == totalEmail + 3 {
                        return self.configureSendButtonCell(indexPath: indexPath)
                    }else if index == totalEmail + 4 {
                        return self.configureShareItemCell(indexPath: indexPath)
                    }
                    else {
                        return UITableViewCell()
                    }
                }
            }else {
                if receiver.isExpand == false {
                    if indexPath.row == 1 {
                        
                        let cell = self.tblDownload.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
                        cell.nameLabel.text = "Receiver List"
                        cell.removeButton.isHidden = true
                        return cell
                        
                        
                    }else if indexPath.row == 2{
                        return self.configureContactCell(indexPath: indexPath)
                    }else if indexPath.row == 3{
                        return self.configureContentCell(indexPath: indexPath)
                        
                    }else if indexPath.row == 4 {
                        return self.configureOptionsCell(indexPath: indexPath)
                        
                    }else if indexPath.row == 5 {
                        return self.configureSendButtonCell(indexPath: indexPath)
                    }
                    else if indexPath.row == 6 {
                        return self.configureShareItemCell(indexPath: indexPath)
                    }
                    else {
                        return UITableViewCell()
                    }
                    
                    
                    
                }
                if indexPath.row == 1 {
                    return self.configureContactCell(indexPath: indexPath)
                }else if indexPath.row == 2{
                    return self.configureContentCell(indexPath: indexPath)
                }else if indexPath.row == 3{
                    return self.configureOptionsCell(indexPath: indexPath)
                }else if indexPath.row == 4 {
                    return self.configureSendButtonCell(indexPath: indexPath)
                }else if indexPath.row == 5 {
                    return self.configureShareItemCell(indexPath: indexPath)
                }
                else {
                    return UITableViewCell()
                }
            }
            
        }else{
            
            switch indexPath.row {
            case ShareScreenFields.contact.rawValue , ShareScreenFields.subject.rawValue:
                return self.configureContactCell(indexPath: indexPath)
            case ShareScreenFields.content.rawValue:
                return self.configureContentCell(indexPath: indexPath)
            case ShareScreenFields.options.rawValue:
                return self.configureOptionsCell(indexPath: indexPath)
            case ShareScreenFields.send.rawValue:
                return self.configureSendButtonCell(indexPath: indexPath)
            case ShareScreenFields.share.rawValue:
                return self.configureShareItemCell(indexPath: indexPath)
            default:
                return UITableViewCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if receiver.arrEmailId.count > 0 {
            if indexPath.row == 1 {
                receiver.isExpand = !receiver.isExpand
                self.tblDownload.reloadData()
            }
        }
    }
    
    func configureShareItemCell(indexPath : IndexPath) -> UITableViewCell{
        let cell = self.tblDownload.dequeueReusableCell(withIdentifier: "ShareItemCell", for: indexPath) as? ShareItemCell
        cell?.lblItemName.text = "\(objFolder.folderNM ?? "")"
        return cell ?? UITableViewCell()
    }
    
    func configureContactCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = self.tblDownload.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell
        switch indexPath.row {
        case ShareScreenFields.contact.rawValue:
            cell?.nameLabel.text = "To:"
            cell?.addButton.isHidden = false
            cell?.backgroundColor = UIColor.hexStringToUIColor(hex: "EEF4FE")
            cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell?.addButton.addTarget(self, action: #selector(self.addButtonAction(_:)), for: .touchUpInside)
            cell?.btnAddEmail.addTarget(self, action: #selector(self.addButtonAction(_:)), for: .touchUpInside)
        case ShareScreenFields.subject.rawValue:
             cell?.nameLabel.text = "Subject"
            cell?.subjectClosure  { newText in
                self.strSubject = newText
            }
            cell?.addButton.isHidden = true
           cell?.btnAddEmail.isHidden = true
           cell?.contactTextField.isHidden = false
             cell?.backgroundColor = UIColor.white
        default:
            break
        }
        return cell ?? UITableViewCell()
    }
    func configureContentCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = self.tblDownload.dequeueReusableCell(withIdentifier: "TextViewTableViewCell", for: indexPath) as? TextViewTableViewCell
        cell?.textView.text = "Compose Mail"
        cell?.textChanged {[weak tblDownload] newText in
            self.strTextView = newText
            
            DispatchQueue.main.async {
                tblDownload?.beginUpdates()
                tblDownload?.endUpdates()
            }
        }
        return cell ?? UITableViewCell()
    }
    func configureOptionsCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = self.tblDownload.dequeueReusableCell(withIdentifier: "ShareOptionsTableViewCell", for: indexPath) as? ShareOptionsTableViewCell
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        //"F4BD41" , "D7D7D7"
        cell?.configureShareLabel(mainString: "Share expires in 30 days", subString: "30")
        return cell ?? UITableViewCell()
    }
    func configureSendButtonCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = self.tblDownload.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as? ButtonTableViewCell
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell?.btnSend.addTarget(self, action: #selector(self.btnSendAction(_:)), for: .touchUpInside)
        return cell ?? UITableViewCell()
    }
}

