//
//  DataRoomViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 25/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit
import SwipeCellKit
import ObjectMapper
import QuickLook

enum FolderViewType : Int {
    case list
    case grid
}
class DataRoomViewController: UIViewController {
    
    @IBOutlet weak var actionButtonsContainerView: UIView!
    @IBOutlet weak var actionFolderButton: UIButton!
    @IBOutlet weak var actionFileButton: UIButton!
    @IBOutlet weak var listingCollectionView: UICollectionView!
    var arrFolder = [Any]()
    var currentFolderPageIndex: Int = -1
    var arrayOfFolderId = Array<Int>()
    var currentIndexForEdit: Int = -1 
    var activeViewType = FolderViewType.list
    var folderNameArray = ["Documents 1" , "Documents 2"]
    
    lazy var previewItem = NSURL()
    var documentPicker: UIDocumentPickerViewController!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.arrayOfFolderId.append(0)
        self.wsCallGetRootFolders()
        self.setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        var isSetTitle = false
        if self.arrayOfFolderId.count > 1 {
            isSetTitle = true
        }
        self.setTitleOfBarButton(isSetTitle: isSetTitle)
        
    }
    
    @IBOutlet var backBarButton: UIBarButtonItem!
    func setTitleOfBarButton(isSetTitle: Bool){
        if isSetTitle == true {
            backBarButton.title = "Back"
            backBarButton.isEnabled = true
        }else {
            backBarButton.title = ""
            backBarButton.isEnabled = false
        }
        
    }
    
    @IBAction func backButtonTapAction(_ sender: UIBarButtonItem) {
        if self.arrayOfFolderId.count > 1 {
            self.arrayOfFolderId.removeLast()
            if self.arrayOfFolderId.count == 1 {
                setTitleOfBarButton(isSetTitle: false)
                folderID = "\(self.arrayOfFolderId[0])"
                self.wsCallGetRootFolders()
            }else {
                if let objFolderId = self.arrayOfFolderId.last {
                    folderID = "\(objFolderId)"
                    self.wsCallGetChildListFolders()
                }
            }
        }
    }
    
    //    func callAPIAfterRename(){
    //        if let objFolderId = self.arrayOfFolderId.last {
    //            folderID = "\(objFolderId)"
    //            self.wsCallGetChildListFolders()
    //        }
    //    }
    func setUI() {
        addSearchButton()
        let titleLabel = Utilities.titleLabel()
        titleLabel.text = "Data Room"
        navigationItem.titleView = titleLabel
        self.showHideAddButtonActions(needToHide: true)
        self.setUploadDownloadStateUpdate()
    }
    func setUploadDownloadStateUpdate(){
        let dm = FileDownloadManager.shared
        dm.currentDownload = { obj in
            getMainQueue {
                if let index = self.arrFolder.firstIndex(where: { (objectFile) -> Bool in
                    if let file = objectFile as? UnIndexDocumentList {
                        return file.id == obj.id
                    }else {
                        return false
                    }
                }){
                    if let file = self.arrFolder[index] as? UnIndexDocumentList {
                        file.currentStatusOfDownload = .downloading
                        self.arrFolder[index] = file
                        self.listingCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                    }
                    if let cell = self.listingCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? folderListCollectionViewCell {
                        dm.progressBlock = { progress in
                            getMainQueue {
                                if let fProgress = progress {
                                    let finalProgres = String(format: "%.0f", fProgress * 100)
                                    cell.lblDownloadState.text = "Downloading.. \(finalProgres)%"
                                }
                            }
                        }
                        dm.sucessBlock = { progress in
                            getMainQueue {
                                if let file = self.arrFolder[index] as? UnIndexDocumentList {
                                    file.currentStatusOfDownload = .downloaded
                                    self.arrFolder[index] = file
                                    self.listingCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                                }
                            }
                        }
                    }
                }
            }
        }
        let um = FileUploadManager.shared
        um.currentUpload = { obj in
            getMainQueue {
                if let index = self.arrFolder.firstIndex(where: { (objectFile) -> Bool in
                    if let file = objectFile as? UnIndexDocumentList {
                        return file.fileName == obj.fileName
                    }else {
                        return false
                    }
                }){
                    if let file = self.arrFolder[index] as? UnIndexDocumentList {
                        file.currentStatusOfDownload = .uploading
                        self.arrFolder[index] = file
                        self.listingCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                        if let cell = self.listingCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? folderListCollectionViewCell {
                            getMainQueue {
                                cell.lblDownloadState.text = "Uploading..."
                            }
                        }
                    }
                    if let cell = self.listingCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as? folderListCollectionViewCell {
                        dm.progressBlock = { progress in
                            getMainQueue {
                                if let fProgress = progress {
                                    let finalProgres = String(format: "%.0f", fProgress * 100)
                                    cell.lblDownloadState.text = "Uploading... \(finalProgres)%"
                                }
                            }
                        }
                        dm.sucessBlock = { progress in
                            getMainQueue {
                                if let file = self.arrFolder[index] as? UnIndexDocumentList {
                                    file.currentStatusOfDownload = .uploaded
                                    self.arrFolder[index] = file
                                    self.listingCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                                }
                            }
                        }
                    }
                }
            }
        }
      
        
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
        showAddFilePopUp()
    }
    @IBAction func addFolderButtonAction(_ sender: Any) {
        self.showHideAddButtonActions(needToHide: true)
        showFolderCreationPopUp()
    }
    func showFolderCreationPopUp(isFileCreation : Bool = false) {
        let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateFolderPopUpViewController") as! CreateFolderPopUpViewController
        alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        alertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        alertView.delegate = self
        alertView.popupType = ePopupType.folderCreate
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
extension DataRoomViewController : TextFieldPopUpDelegate {
    func addFolder(_ folderName: String, isFileCreation: Bool) {
        if isFileCreation {
            self.showUploadingAlert()
        } else {
            if isFileCreation == false {
                if folderName.isBlank == false {
                    
                    if let objData = self.arrFolder[self.currentIndexForEdit] as? DataObject {
                        self.wsCallRenameFolderName(currentFolderPath: objData.folderPath!, newFolderPath: folderName, folderType: objData.folderType!, folderId: objData.folderID, index: self.currentIndexForEdit)
                        
                    }else if let objData = self.arrFolder[self.currentIndexForEdit] as? UnIndexDocumentList{
                        
                        // self.wsCallRenameFolderName(currentFolderPath: objData.folderPath!, newFolderPath: folderName, folderType: objData.folderType!, folderId: objData.folderID, index: self.currentIndexForEdit)
                    }
                }
            }
            //            if folderName != "" {
            //                self.folderNameArray.append(folderName)
            //                listingCollectionView.reloadData()
            //            }
        }
    }
}
extension DataRoomViewController : FileCreationPopUpDelegate {
    func showFileNamePopUp() {
        self.showOptionForDocument()
        
        //self.showFolderCreationPopUp(isFileCreation: true)
    }
}
extension DataRoomViewController : UISearchBarDelegate {
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
extension DataRoomViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  self.arrFolder.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch activeViewType {
        case .list:
            
            if let file = self.arrFolder[indexPath.item] as? UnIndexDocumentList {
                if file.currentStatusOfDownload == .downloading  || file.currentStatusOfDownload == .uploading{
                    return CGSize(width: collectionView.frame.width, height: 80)
                }
            }
            
            return CGSize(width: collectionView.frame.width, height: 50)
            
            
            
        case .grid:
            let width = (collectionView.frame.width / 2) - 20
            return CGSize(width: width, height: 50)
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch activeViewType {
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folderListCollectionViewCell", for: indexPath) as? folderListCollectionViewCell
            cell?.ivRightArrow.isHidden = false
            cell?.delegate = self
            cell?.nameLabel.textColor = UIColor.black
            cell?.contentLabel.textColor = Utilities.hexStringToUIColor(hex: "#FCDD65")
            
            if let objData =  self.arrFolder[indexPath.row] as? DataObject {
                cell?.nameLabel.text = objData.folderNM
                var totlaFile: Int  = 0
                if let noOfFiles = objData.noOfFiles {
                    totlaFile = noOfFiles
                }
                cell?.contentLabel.text = String("\(totlaFile) Files")
                cell?.ivFileType.image = #imageLiteral(resourceName: "document_folder")
                cell?.lblDownloadState.text = ""
                if let arrGesture = cell!.contentView.gestureRecognizers  {
                    for gesture in arrGesture {
                        cell!.contentView.removeGestureRecognizer(gesture)
                    }
                }
                if objData.deleteType == .soft {
                    cell?.nameLabel.textColor = UIColor.red
                    cell?.contentLabel.textColor = UIColor.red
                }
            }else {
                let objData =  self.arrFolder[indexPath.row] as! UnIndexDocumentList
                cell?.nameLabel.text = objData.fileName
                //cell?.contentLabel.text = "\(objData.noOfFiles) Files"
                cell?.ivRightArrow.isHidden = true
                if objData.fileType == eFileType.pdf.rawValue  {
                    cell?.ivFileType.image = #imageLiteral(resourceName: "ic_pdf")
                }else if objData.fileType == eFileType.docx.rawValue{
                    cell?.ivFileType.image = #imageLiteral(resourceName: "doc_icon")
                }else if objData.fileType == eFileType.xlsx.rawValue{
                    cell?.ivFileType.image = #imageLiteral(resourceName: "ic_excel")
                }else{
                    cell?.ivFileType.image = #imageLiteral(resourceName: "document_folder")
                }
                cell?.contentView.isUserInteractionEnabled = true
                cell?.contentView.onLongPress.handle(with: { (longPress) in
                    if longPress.state == .began {
                        self.actionSheetForLongPeress(indexPath: indexPath)
                    }
                })
                if objData.deleteType == .soft {
                    cell?.nameLabel.textColor = UIColor.red
                    cell?.contentLabel.textColor = UIColor.red
                }
                cell?.lblDownloadState.text = ""
                
                
            }
            return cell ?? UICollectionViewCell()
        case .grid:
            return UICollectionViewCell()
            
        //            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folderGridCollectionViewCell", for: indexPath) as? folderGridCollectionViewCell
        //            if let objData =  self.arrFolder[indexPath.row] as? DataObject {
        //                cell?.delegate = self
        //                cell?.nameLabel.text = objData.folderNM
        //                cell?.contentLabel.text = String("\(objData.noOfFiles) Files")
        //
        //            }else {
        //                let objData =  self.arrFolder[indexPath.row] as! UnIndexDocumentList
        //                cell?.nameLabel.text = objData.fileName
        //                cell?.contentLabel.text = "\(objData.noOfFiles) Files"
        //
        //                if objData.fileType == eFileType.pdf.rawValue  {
        //                cell?.ivFileType.image = #imageLiteral(resourceName: "ic_pdf")
        //                }else if objData.fileType == eFileType.docx.rawValue{
        //                    cell?.ivFileType.image = #imageLiteral(resourceName: "doc_icon")
        //                }else if objData.fileType == eFileType.xlsx.rawValue{
        //                   cell?.ivFileType.image = #imageLiteral(resourceName: "ic_excel")
        //                }else{
        //                   cell?.ivFileType.image = #imageLiteral(resourceName: "document_folder")
        //                }
        //            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let objFolderData =  self.arrFolder[indexPath.row] as? DataObject {
            
            self.arrayOfFolderId.append(objFolderData.folderID)
            folderID = "\(objFolderData.folderID)"
            setTitleOfBarButton(isSetTitle: true)
            self.wsCallGetChildListFolders()
        }else {
            if let objFolderData =  self.arrFolder[indexPath.row] as? UnIndexDocumentList {
                let fileName = "\(objFolderData.folderID)_\(objFolderData.fileName)"
                var url = DirectoryManager.getTempDir(dirName: fileName)
                print("Download Temp Path :: ",url)
                if var urld = DirectoryManager.getDir(dirName: Constant.downloadedDocument) {
                    urld.appendPathComponent(fileName)
                    url = urld
                }
                if DirectoryManager.fileExists(at: url) {
                    self.previewItem = url as NSURL
                    self.presentQuickLook()
                }
            }
        }
        //        else if let objFolderData =  self.arrFolder[indexPath.row] as? UnIndexDocumentList {
        //            self.arrayOfFolderId.append(objFolderData.folderID)
        //            folderID = "\(objFolderData.folderID)"
        //            setTitleOfBarButton(isSetTitle: true)
        //            self.wsCallGetChildListFolders()
        //        }
        //        let objFolderData = self.arrFolder[indexPath.item]
        //        //if objFolderData.folderID > 0 {
        //            self.arrayOfFolderId.append(objFolderData.folderID)
        //            folderID = "\(objFolderData.folderID)"
        //            setTitleOfBarButton(isSetTitle: true)
        //            self.wsCallGetChildListFolders()
        // }
        
        
        
        //        if let personalFileVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PersonalFileViewController") as? PersonalFileViewController {
        //            self.navigationController?.pushViewController(personalFileVC, animated: true)
        //        }
        
    }
    
//MARK :-
    
    func actionSheetForLongPeress(indexPath: IndexPath){
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let selectAll = UIAlertAction(title: "Select All", style: .default, handler: { alert in
            print("Select All")
        })
        alertController.addAction(selectAll)
        
        let share = UIAlertAction(title: "Share", style: .default, handler: { alert in
            print("Share")
        })
        alertController.addAction(share)
        
        let delete = UIAlertAction(title: "Delete", style: .default, handler: { alert in
            print("Delete")
        })
        alertController.addAction(delete)
        
        let move = UIAlertAction(title: "Move", style: .default, handler: { alert in
            print("Move")
        })
        alertController.addAction(move)
        
        let copy = UIAlertAction(title: "Copy", style: .default, handler: { alert in
            print("Copy")
        })
        alertController.addAction(copy)
        
        let download = UIAlertAction(title: "Download", style: .default, handler: { alert in
            print("Download")
            
            if let objData =  self.arrFolder[indexPath.row] as? UnIndexDocumentList {
                let fileName = "\(objData.folderID)_\(objData.fileName)"
                var url = DirectoryManager.getTempDir(dirName: fileName)
                print("Download Temp Path :: ",url)
                if var urld = DirectoryManager.getDir(dirName: Constant.downloadedDocument) {
                    urld.appendPathComponent(fileName)
                    url = urld
                }
                
                if DirectoryManager.fileExists(at: url) {
                    self.previewItem = url as NSURL
                    self.presentQuickLook()
                }else {
                    let fileDownloadManager = FileDownloadManager.shared
                    fileDownloadManager.arrayOfDownload.append(DataOfDownloadFile(document: objData))
                    objData.currentStatusOfDownload = .notStarted
                    self.arrFolder[indexPath.row] = objData
                    fileDownloadManager.startDownload()
                }
            }
            
        })
        alertController.addAction(download)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { alert in
            print("Cancel")
        })
        alertController.addAction(cancel)
        /*
         Select All
         Share
         Delete
         Move
         Copy
         Download
         */
        self.present(alertController, animated: true, completion: nil)
        
    }
    func showOptionForDocument(){
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let selectAll = UIAlertAction(title: "Document", style: .default, handler: { alert in
            self.openDocumentPickerViewController()
        })
        alertController.addAction(selectAll)
        
        let share = UIAlertAction(title: "Photo", style: .default, handler: { alert in
            ImagePicker.shared.getImagePickerActionSheetAndImage(vc: self) { (image) in
                do {
                    if let img = image, let data = img.jpegData(compressionQuality: 0.5) {
                        let fileName = "\(self.arrayOfFolderId.last!)_\(Date().toMillis()).jpeg"
                        if var urld = DirectoryManager.getDir(dirName: Constant.downloadedDocument) {
                            urld.appendPathComponent(fileName)
                           try data.write(to: urld)
                            self.fileToUpload(filePath: urld, fileName: fileName)
                        }
                    }
                }catch let error {
                    showInfoMessage(messsage: error.localizedDescription)
                }
            }
        })
        alertController.addAction(share)
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { alert in
            print("Cancel")
        })
        alertController.addAction(cancel)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openDocumentPickerViewController(){
        self.documentPicker = UIDocumentPickerViewController(documentTypes: ["public.data","public.content","public.audiovisual-content","public.movie","public.audiovisual-content","public.video","public.audio","public.data","public.zip-archive","com.pkware.zip-archive","public.composite-content","public.text"], in: UIDocumentPickerMode.import)
        documentPicker.delegate = self
        self.present(self.documentPicker, animated: true, completion: nil)
    }
    func fileToUpload(filePath: URL,fileName: String){
        print("File URL To Upload :: ",filePath)
        let um = FileUploadManager.shared
    
        let objUpload = UnIndexDocumentList()
        objUpload.fileName = fileName
        objUpload.folderID = self.arrayOfFolderId.last!
        objUpload.parentFolderID = self.arrayOfFolderId.last!
        objUpload.fileType = filePath.pathExtension
        self.arrFolder.append(objUpload)
        self.listingCollectionView.reloadData()
        
        objUpload.currentStatusOfDownload = .notStarted
        um.arrayOfUpload.append(UploadData(filePath: filePath, fileName: fileName, fileSize: filePath.fileSize, upload: objUpload))
        um.startUpload()
        
//        let fileDownloadManager = FileDownloadManager.shared
//        fileDownloadManager.arrayOfDownload.append(DataOfDownloadFile(document: objData))
//        objData.currentStatusOfDownload = .notStarted
//        self.arrFolder[indexPath.row] = objData
//        fileDownloadManager.startDownload()
        
    }
}
extension DataRoomViewController : SwipeCollectionViewCellDelegate {
    func collectionView(_ collectionView: UICollectionView, editActionsForItemAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        
        guard orientation == .right else { return nil }
        
        var deleteType = eDeletedType.none
        if let objFolderData =  self.arrFolder[indexPath.row] as? DataObject {
            deleteType = objFolderData.deleteType
        }else if let objFolderData =  self.arrFolder[indexPath.row] as? UnIndexDocumentList {
            deleteType = objFolderData.deleteType
        }
        
        if deleteType == .soft{
            return [self.getSwipeButtonForDelete(title: eSwipeOption.delete.rawValue, imageName: "delete_red"),self.getSwipeButtonForDelete(title: eSwipeOption.restore.rawValue, imageName: "delete_white")]
        }else{
            
            return [self.getSwipeButtonForDelete(title: eSwipeOption.delete.rawValue, imageName: "delete_white") , self.getSwipeButton(title: eSwipeOption.download.rawValue, imageName: "download_white") , self.getSwipeButton(title: eSwipeOption.permission.rawValue, imageName: "permission") , self.getSwipeButton(title: eSwipeOption.share.rawValue, imageName: "share_white"),self.getSwipeButton(title: eSwipeOption.rename.rawValue, imageName: "ic_edit")]
        }
    }
    
    func getSwipeButtonForDelete(title : String , imageName : String , bgColor : String = "5AB8EE")-> SwipeAction {
        let deleteAction = SwipeAction(style: .default, title: title) { action, indexPath in
            
            if title == eSwipeOption.restore.rawValue{
                var restoreId = ""
                if let objFolderData =  self.arrFolder[indexPath.row] as? DataObject {
                    if objFolderData.deleteType == .soft {
                        objFolderData.deleteType = .none
                        self.arrFolder[indexPath.row] = objFolderData
                    }
                    restoreId = "\(objFolderData.folderID)"
                    
                }else if let objFolderData =  self.arrFolder[indexPath.row] as? UnIndexDocumentList {
                    if objFolderData.deleteType == .soft {
                        objFolderData.deleteType = .none
                        self.arrFolder[indexPath.row] = objFolderData
                    }
                    restoreId = "\(objFolderData.fileID)"
                }
                self.wsCallRestore(obj: restoreId)
                self.listingCollectionView.reloadItems(at: [indexPath])
            }else {
                if let objFolderData =  self.arrFolder[indexPath.row] as? DataObject {
                    if objFolderData.deleteType == .none {
                        objFolderData.deleteType = .soft
                        self.arrFolder[indexPath.row] = objFolderData
                    }
                    folderID = "\(objFolderData.folderID)"
                    
                }else if let objFolderData =  self.arrFolder[indexPath.row] as? UnIndexDocumentList {
                    if objFolderData.deleteType == .none {
                        objFolderData.deleteType = .soft
                        self.arrFolder[indexPath.row] = objFolderData
                    }
                    folderID = "\(objFolderData.fileID)"
                }
                
                self.wsCallDelete()
                self.listingCollectionView.reloadItems(at: [indexPath])
            }
        }
        deleteAction.hidesWhenSelected = true
        deleteAction.image = UIImage(named: imageName)
        deleteAction.font =  UIFont(name: "Helvetica", size: 9.0)!
        deleteAction.backgroundColor = UIColor.hexStringToUIColor(hex:bgColor)
        return deleteAction
    }
    
    func getSwipeButton(title : String , imageName : String , bgColor : String = "5AB8EE")-> SwipeAction {
        let deleteAction = SwipeAction(style: .default, title: title) { action, indexPath in
            
            if title == eSwipeOption.delete.rawValue{
                
            }else if title == eSwipeOption.share.rawValue{
                if let shareVC = self.storyboard?.instantiateViewController(withIdentifier: "ShareViewViewController") as? ShareViewViewController{
                    
                    if let objFolderData =  self.arrFolder[indexPath.row] as? DataObject {
                        shareVC.objDocTobeShare = objFolderData
                        
                    }else if let objFolderData =  self.arrFolder[indexPath.row] as? UnIndexDocumentList {
                        shareVC.objDocTobeShare = objFolderData
                    }
                    
                    self.navigationController?.pushViewController(shareVC, animated: true)
                }
            }else if title == eSwipeOption.rename.rawValue{
                let alertView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CreateFolderPopUpViewController") as! CreateFolderPopUpViewController
                alertView.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                alertView.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
                alertView.delegate = self
                self.currentIndexForEdit = indexPath.row
                alertView.popupType = ePopupType.renameFolder
                if let objData = self.arrFolder[self.currentIndexForEdit] as? DataObject {
                    alertView.currentFolderName = objData.folderNM!
                }
                self.present(alertView, animated: false) {
                    
                }
            }else if title == eSwipeOption.download.rawValue{
                if let downloadVC = self.storyboard?.instantiateViewController(withIdentifier: "RequestDepositViewController") as? RequestDepositViewController{
                    if let objFolderData =  self.arrFolder[indexPath.row] as? DataObject {
                        downloadVC.objFolder = objFolderData
                    }
                    self.navigationController?.pushViewController(downloadVC, animated: true)
                }
            }
            
        }
        deleteAction.hidesWhenSelected = true
        deleteAction.image = UIImage(named: imageName)
        deleteAction.font =  UIFont(name: "Helvetica", size: 9.0)!
        deleteAction.backgroundColor = UIColor.hexStringToUIColor(hex:bgColor)
        return deleteAction
    }
}
class folderListCollectionViewCell : SwipeCollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet var ivFileType: UIImageView!
    @IBOutlet var ivRightArrow: UIImageView!
    @IBOutlet var lblDownloadState: UILabel!
}
class folderGridCollectionViewCell : UICollectionViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet var ivFileType: UIImageView!
    @IBOutlet var ivRightArrow: UIImageView!
    @IBOutlet var lblDownloadState: UILabel!
}

extension DataRoomViewController {
    func wsCallGetRootFolders(){
        _ = APIManager.shared.requestGetJSON(url: eAppURL.fetchAllAdmFolderListResponse, parameters: [:], isShowIndicator: true, completionHandler: { (result) in
            switch result {
            
            case .success(let dicData):
                if let objResponse = dicData as? Dictionary<String,Any> {
                    let objUser: GetRootFolders = Mapper().map(JSON: objResponse)!
                    print(objUser)
                    self.arrFolder.removeAll()
                    objUser.object?.forEach({ (folderObject) in
                        print("folder objects",folderObject)
                        self.arrFolder.append(folderObject)
                    })
                    self.listingCollectionView.reloadData()
                }
                
            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        })
    }
    
    func wsCallRenameFolderName(currentFolderPath: String ,newFolderPath: String ,folderType: String, folderId: Int, index:Int){
        
        var dicParameter = Dictionary<String,Any>()
        dicParameter["currentFolderPath"] = currentFolderPath
        dicParameter["newFolderPath"] = newFolderPath
        dicParameter["folderType"] = folderType
        dicParameter["folderId"] = folderId
        
        _ = APIManager.shared.requestPostJSON(url: eAppURL.admRenameNewFolderServiceAfter, parameters: dicParameter, isShowIndicator: true, completionHandler: { (result) in
            switch result {
            
            case .success(let dicData):
                //                if let objResponse = dicData as? Dictionary<String,Any> {
                //                }
                if let objData = self.arrFolder[index] as? DataObject {
                    objData.folderNM = newFolderPath
                    self.arrFolder[index] = objData
                    self.listingCollectionView.reloadItems(at: [IndexPath(item: index, section: 0)])
                }
                
            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        })
    }
    func wsCallGetChildListFolders(){
        _ = APIManager.shared.requestGetJSON(url: eAppURL.fetchAllAdmFolderChildListResponse, parameters: [:], isShowIndicator: true, completionHandler: { (result) in
            switch result {
            
            case .success(let dicData):
                if let objResponse = dicData as? Dictionary<String,Any> {
                    let objUser: ChildFolderData = Mapper().map(JSON: objResponse)!
                    print(objUser)
                    self.arrFolder.removeAll()
                    
                    if let obj = objUser.object {
                        if let unIndexFoldersList = obj.unIndexFoldersList {
                            unIndexFoldersList.forEach({ (folderObject) in
                                print("folder objects",folderObject)
                                self.arrFolder.append(folderObject)
                            })
                        }
                        if let unIndexDocumentsList = obj.unIndexDocumentsList {
                            unIndexDocumentsList.forEach({ (folderObject) in
                                print("folder objects",folderObject)
                                self.arrFolder.append(folderObject)
                            })
                        }
                    }
                    
                    
                    self.listingCollectionView.reloadData()
                    //                    if let token = objUser.object?.first{
                    //                        let foldername = token.folderNM
                    //                        print("hi",foldername)
                    //                    }
                }
                
            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        })
    }
    
    func wsCallDelete(){
        
        _ = APIManager.shared.requestPostJSON(url: eAppURL.deleteFolder, parameters: [:], isShowIndicator: true, completionHandler: { (result) in
            switch result {
            // {{localhost}}/api.acms/v1/app/unindexfolderdeleteg/0/5/admDeleteFolderServiceAfter
            case .success(let dicData):
                if let objResponse = dicData as? Dictionary<String,Any> {
                    print("Deleted API Call",objResponse)
                    
                }
                
            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        })
    }
    func wsCallRestore(obj: String){
        var parameters = Dictionary<String,Any>()
        parameters["attribute1"] = obj
        
        _ = APIManager.shared.requestPostJSON(url: eAppURL.restoreTrashedDocsAfter, parameters: parameters, isShowIndicator: true, completionHandler: { (result) in
            switch result {
            // {{localhost}}/api.acms/v1/app/unindexfolderdeleteg/0/5/admDeleteFolderServiceAfter
            case .success(let dicData):
                if let objResponse = dicData as? Dictionary<String,Any> {
                    print("Deleted API Call",objResponse)
                    
                }
                
            case .failure(let error):
                showInfoMessage(messsage: error.localizedDescription)
            }
        })
    }
    
}
extension DataRoomViewController:QLPreviewControllerDataSource, QLPreviewControllerDelegate {
    // This method will open  quick look preview controller.
    
    private func presentQuickLook(){
        DispatchQueue.main.async { [weak self] in
            let previewController = QLPreviewController()
            previewController.modalPresentationStyle = .popover
            previewController.dataSource = self
            previewController.navigationController?.title = ""
            self?.navigationController?.pushViewController(previewController, animated: true)
            //        ?.present(previewController, animated: true, completion: nil)
        }
    }
    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int { return 1 }
    
    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        return self.previewItem as QLPreviewItem
    }
}

//MARK:- DocumentPicker Delegate
extension DataRoomViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        if controller.documentPickerMode == UIDocumentPickerMode.import {
            do {
                if let firstURL = urls.first {
                    let fileName = "\(self.arrayOfFolderId.last!)_\(self.randomString(length: 2))\(firstURL.lastPathComponent)"
                    if var urld = DirectoryManager.getDir(dirName: Constant.downloadedDocument) {
                        urld.appendPathComponent(fileName)
                        let finalURL = URL(fileURLWithPath: urld.path)
                        try FileManager.default.copyItem(at: firstURL, to: finalURL)
                        self.fileToUpload(filePath: finalURL, fileName: fileName)
                    }
                }
            }catch let  error {
                showInfoMessage(messsage: error.localizedDescription)
            }
            
            
            
            //            DisplayMedia.saveFileInDirectory(otherUserID: self.objOtherUser.user_id, currentPath: urls[0])
            //            self.sendMessage(mediaFilePath: urls[0].absoluteString, duration: nil, captionString: "",eMessageType: eChatMessageType.messageDoc)
            //
        }
    }
    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    func randomString(length: Int) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
