//
//  ShareViewViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 29/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import Sensitive
struct Receiver {
    var arrEmailId:Array<EmailID>
    var isExpand: Bool = false
}

class ShareViewViewController: UIViewController {

    var receiver = Receiver(arrEmailId: Array<EmailID>())
    
    enum ShareScreenFields : Int {
        case contact
        case subject
        case content
        case options
        case send
        case share
        case rowCount
    }
    
    var objDocTobeShare: Any!
    @IBOutlet weak var contentTableView: UITableView!
    var strTextView : String = ""
    var strSubject : String = ""
        
    //MARK:- View cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    
        self.navigationItem.title = "Share"
        self.contentTableView.tableFooterView = UIView()
        //"8-2-2021 14:54:32"
        dateAndTimeForShare =  Date().getFormattedDate(format: "D-M-yyyy HH:mm:ss")
        
    }
    
    //MARK:- User defined functions
    
    func showAddContactPopUp() {
        let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AddContactPopUpViewController") as! AddContactPopUpViewController
        alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        alertView.callback = { objEmailAndPhone in
            if let objEmailAndPhone = objEmailAndPhone {
                self.receiver.arrEmailId.append(objEmailAndPhone)
                self.contentTableView.reloadData()
            }
        }
        alertView.emailList = self.receiver.arrEmailId
        self.present(alertView, animated: false)
    }
    
    @objc func addButtonAction(_ sender : UIButton) {
        self.showAddContactPopUp()
    }
}

//MARK:- tableview datasource and delegates

extension ShareViewViewController :  UITableViewDataSource , UITableViewDelegate {
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
                   
                    let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
                        cell.nameLabel.text = "Receiver List"
                        cell.removeButton.isHidden = true
                    return cell
                }else {
                    let totalEmail = receiver.arrEmailId.count
                    let index = indexPath.row - 2
                    if index < totalEmail {
                        
                        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
                        cell.nameLabel.text = receiver.arrEmailId[index].emailId
                        cell.removeButton.isHidden = false
                        cell.removeButton.isUserInteractionEnabled = true
                        cell.removeButton.onTap.handle { (tap) in
                            if tap.state == .ended {
                                self.receiver.arrEmailId.remove(at: index)
                                self.contentTableView.reloadData()
                            }
                        }
                        
                        
                        return cell
                    }else if index == totalEmail {
                        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as! ContactTableViewCell
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
                        
                        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "ReceiverTableViewCell", for: indexPath) as! ReceiverTableViewCell
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
                    }else if indexPath.row == 6 {
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
        
        }else {
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
                self.contentTableView.reloadData()
            }
        }
    }
    
    func configureContactCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "ContactTableViewCell", for: indexPath) as? ContactTableViewCell
        switch indexPath.row {
        case ShareScreenFields.contact.rawValue:
            cell?.nameLabel.text = "To:"
            cell?.addButton.isHidden = false
            cell?.backgroundColor = UIColor.hexStringToUIColor(hex: "EEF4FE")
            cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
            cell?.addButton.addTarget(self, action: #selector(self.addButtonAction(_:)), for: .touchUpInside)
            cell?.btnAddEmail.addTarget(self, action: #selector(self.addButtonAction(_:)), for: .touchUpInside)
            cell?.contactTextField.isHidden = true
        case ShareScreenFields.subject.rawValue:
            cell?.subjectClosure  { newText in
                self.strSubject = newText
            }
             cell?.nameLabel.text = "Subject"
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
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "TextViewTableViewCell", for: indexPath) as? TextViewTableViewCell
        cell?.textView.text = "Compose Mail"
        cell?.textChanged {[weak contentTableView] newText in
            self.strTextView = newText
            
            DispatchQueue.main.async {
                contentTableView?.beginUpdates()
                contentTableView?.endUpdates()
            }
        }
    
        return cell ?? UITableViewCell()
    }
    func configureOptionsCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "ShareOptionsTableViewCell", for: indexPath) as? ShareOptionsTableViewCell
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        //"F4BD41" , "D7D7D7"
        cell?.configureShareLabel(mainString: "Share expires in 30 days", subString: "30")
        cell?.btnInfiniteDays.addTarget(self, action: #selector(self.btnInfiniteClicked(sender:)), for: .touchUpInside)
        cell?.btnInfiniteDays.tag = indexPath.row
      //  cell?.btnReadOnly.addTarget(self, action: #selector(self.btnReadOnlyClicked:), for: .touchUpInside)
     //   cell?.btnAllowPrint.addTarget(self, action: #selector(self.btnAllowPrintClicked), for: .touchUpInside)

        return cell ?? UITableViewCell()
    }
    func configureSendButtonCell(indexPath : IndexPath) -> UITableViewCell {
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "ButtonTableViewCell", for: indexPath) as? ButtonTableViewCell
        cell?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: UIScreen.main.bounds.width)
        cell?.btnSend.addTarget(self, action: #selector(self.shareData), for: UIControl.Event.touchUpInside)
        return cell ?? UITableViewCell()
    }
    
    func configureShareItemCell(indexPath : IndexPath) -> UITableViewCell{
        let cell = self.contentTableView.dequeueReusableCell(withIdentifier: "ShareItemCell", for: indexPath) as? ShareItemCell
        if let objFolderData =  self.objDocTobeShare as? DataObject {
            cell?.lblItemName.text = "\(objFolderData.folderNM ?? "")"

        }else if let objFolderData =  self.objDocTobeShare as? UnIndexDocumentList {
            cell?.lblItemName.text = "\(objFolderData.fileName)"

        }
        return cell ?? UITableViewCell()
    }
    
    //MARK:- Button Actions
    
    @objc func btnInfiniteClicked(sender : UIButton){
        let indexpath = IndexPath.init(row: sender.tag, section: 0)
        let cell : ShareOptionsTableViewCell = self.contentTableView.cellForRow(at: indexpath) as! ShareOptionsTableViewCell
        if cell.infiniteDays == .unchecked{
            cell.infiniteDays = .checked
        }else{
            cell.infiniteDays = .unchecked
        }
        DispatchQueue.main.async {
            self.contentTableView.reloadRows(at: [indexpath], with: .none)
        }


    }
    
    @objc func btnReadOnlyClicked(){
        
    }
    
    @objc func btnAllowPrintClicked(){
        
    }
    
    @objc func shareData(){
        if self.receiver.arrEmailId.count <= 0 {
            showInfoMessage(messsage: "Enter email address!")
            return
        }else{
            self.wsCallShare()
        }
    }
    
    func wsCallShare(){
        dateAndTimeForShare = Date().getFormattedDate(format: "d-M-yyyy HH:mm:ss")
        //var parameter = Dictionary<String,Any>()


        var arrayOfEmail = Array<Dictionary<String,Any>>()

        for objEmailId  in self.receiver.arrEmailId {
            arrayOfEmail.append(objEmailId.toDictionary())
        }


        
        let requestShare = RequestShare()
        var docID: Int = 0
        if let objFolderData =  self.objDocTobeShare as? DataObject {
            docID = objFolderData.id ?? 0
            requestShare.folderId  = "\(objFolderData.folderID)"
            requestShare.folderType =  objFolderData.folderType ?? "S"
        }else if let objFolderData =  self.objDocTobeShare as? UnIndexDocumentList {
            docID = objFolderData.id
            requestShare.folderId  = "\(objFolderData.folderID)"
            requestShare.folderType =  "S" //?? "S"
        }
        
        requestShare.docId = ["\(docID)"]
        requestShare.emailidList = arrayOfEmail
        requestShare.serverURL = "https://dcirrus.co.in/api.acms"
        requestShare.expirationDate = "2031-02-06T14:02:00Z"
        requestShare.message = strTextView
        requestShare.subject = self.strSubject
        requestShare.userName  = objLogedInUser.objectD?.name ?? ""
       
        requestShare.allowPrint = "Y"
        requestShare.allowDownload = "Y"
        requestShare.addWaterMark = 1
        requestShare.allowUpload = 1
        requestShare.toSign = 0
        
        /*
         "
            
             "allowDownload": "Y",
             "allowPrint": "Y",
             "addWaterMark": 1,
             "allowUpload": 1,
             "toSign": 0
         */


        _ = APIManager.shared.requestPostJSON(url: eAppURL.admShareURLsServiceAfter, parameters: requestShare.toDictionary(), isShowIndicator: true, completionHandler: { (result) in
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
class ContactTableViewCell : UITableViewCell, UITextFieldDelegate {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var contactTextField: UITextField!
    @IBOutlet var btnAddEmail: UIButton!
    
    var subjectClosure : ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contactTextField.delegate = self
    }
    
    func subjectClosure(action: @escaping (String) -> Void) {
        self.subjectClosure = action
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        subjectClosure?(textField.text ?? "No subject")
    }
    
    
}
class ReceiverTableViewCell : UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var removeButton: UIButton!
    
    
    
    
}
class TextViewTableViewCell : UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var textView: UITextView!
    var textChanged: ((String) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
    }
    
    func textChanged(action: @escaping (String) -> Void) {
        self.textChanged = action
    }
    
    func textViewDidChange(_ textView: UITextView) {
        textChanged?(textView.text)
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Compose Mail"{
            textView.text = ""
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        textChanged?(textView.text)
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        textChanged = nil
    }
    
}
class ShareOptionsTableViewCell : UITableViewCell {
    @IBOutlet weak var shareLabel: UILabel!
    @IBOutlet var btnReadOnly: UIButton!
    @IBOutlet var btnAllowPrint: UIButton!
    @IBOutlet var btnInfiniteDays: UIButton!
    
    var readOnlyState : eShareOptionState = .unchecked{
        didSet{
            if readOnlyState == .unchecked{
                btnReadOnly.setImage(#imageLiteral(resourceName: "box_icon"), for: .normal)
            }else{
                btnReadOnly.setImage(#imageLiteral(resourceName: "ticked_box"), for: .normal)
            }
        }
    }
    
    var allowPrintState : eShareOptionState = .unchecked{
        didSet{
            if allowPrintState == .unchecked{
                btnAllowPrint.setImage(#imageLiteral(resourceName: "box_icon"), for: .normal)
            }else{
                btnAllowPrint.setImage(#imageLiteral(resourceName: "ticked_box"), for: .normal)
            }
        }
    }
    
    var infiniteDays : eShareOptionState = .unchecked{
        didSet{
            if infiniteDays == .unchecked{
                btnInfiniteDays.setImage(#imageLiteral(resourceName: "box_icon"), for: .normal)
            }else{
                btnInfiniteDays.setImage(#imageLiteral(resourceName: "ticked_box"), for: .normal)
            }
        }
    }
    
    func configureShareLabel(mainString : String , subString : String) {
        let mainAttributes = [ NSAttributedString.Key.font: UIFont(name: "Helvetica", size: 10.0)! , NSAttributedString.Key.foregroundColor: UIColor.hexStringToUIColor(hex:"D7D7D7")]
        let myString = NSMutableAttributedString(string: mainString, attributes: mainAttributes )
        if let range = mainString.range(of: subString)?.nsRange(in: mainString){
            let subAttributes = [ NSAttributedString.Key.font: UIFont(name: "Helvetica-Bold", size: 14.0)! , NSAttributedString.Key.foregroundColor: UIColor.hexStringToUIColor(hex:"F4BD41")]
            myString.addAttributes(subAttributes, range: range)
        }
        self.shareLabel.attributedText = myString
    }
}

class ButtonTableViewCell : UITableViewCell {
    @IBOutlet var btnSend: UIButton!
    override func awakeFromNib() {
        self.btnSend.clipsToBounds = true
        self.btnSend.layer.cornerRadius = 25
    }
    
}

class ShareItemCell : UITableViewCell{
    @IBOutlet var lblItemName: UILabel!
    
}

extension ShareViewViewController : UITextViewDelegate{
    
}
