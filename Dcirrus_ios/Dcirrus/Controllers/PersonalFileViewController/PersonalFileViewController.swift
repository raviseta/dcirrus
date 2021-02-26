//
//  PersonalFileViewController.swift
//  Dcirrus
//
//  Created by raviseta on 03/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import UIKit

class PersonalFileViewController: UIViewController {

    @IBOutlet var cvFiles: UICollectionView!
    @IBOutlet weak var actionButtonsContainerView: UIView!
    @IBOutlet weak var actionFolderButton: UIButton!
    @IBOutlet weak var actionFileButton: UIButton!
    
    var personalFileViewModel : PersonalFileViewModel!
    var arrDocumentList = [UnIndexDocumentList]()

    //MARK:- View cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }
    
    func setupUI(){
        
        self.actionFolderButton.clipsToBounds = true
        self.actionFolderButton.layer.cornerRadius = 15
        self.actionFileButton.clipsToBounds = true
        self.actionFileButton.layer.cornerRadius = 15
        self.showHideAddButtonActions(needToHide: true)
        
        self.personalFileViewModel = PersonalFileViewModel()
        personalFileViewModel.wsGetPersonalFiles { (result) in
            switch(result){
            case .success(let objResponse):
                print(objResponse)
                objResponse.object?.unIndexDocumentsList!.forEach({ (tempObject) in
                    self.arrDocumentList.append(tempObject)
                })
                objResponse.object?.unIndexFoldersList?.forEach({ (folderList) in
                    self.arrDocumentList.append(folderList)
                })
                self.cvFiles.reloadData()
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }

    func showHideAddButtonActions(needToHide : Bool) {
        self.actionFolderButton.isHidden = needToHide
        self.actionFileButton.isHidden = needToHide
        self.actionButtonsContainerView.isHidden = needToHide
    }
    
    @IBAction func addButtonAction(_ sender: Any) {
        self.showHideAddButtonActions(needToHide: !self.actionButtonsContainerView.isHidden)
    }
}

//MARK:- CollectionView DataSource and delegate

extension PersonalFileViewController : UICollectionViewDataSource , UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrDocumentList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "folderListCollectionViewCell", for: indexPath) as? folderListCollectionViewCell
        let objData = arrDocumentList[indexPath.row]
        cell?.nameLabel.text = objData.fileName
        cell?.contentLabel.text = "\(objData.noOfFiles) Files"

        if objData.fileType == eFileType.pdf.rawValue  {
        cell?.ivFileType.image = #imageLiteral(resourceName: "ic_pdf")
        }else if objData.fileType == eFileType.docx.rawValue{
            cell?.ivFileType.image = #imageLiteral(resourceName: "doc_icon")
        }else if objData.fileType == eFileType.xlsx.rawValue{
           cell?.ivFileType.image = #imageLiteral(resourceName: "ic_excel")
        }else{
           cell?.ivFileType.image = #imageLiteral(resourceName: "document_folder")
        }
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 50)
    }
}
