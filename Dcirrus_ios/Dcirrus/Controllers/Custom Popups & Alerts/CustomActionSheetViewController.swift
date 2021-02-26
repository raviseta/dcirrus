//
//  CustomActionSheetViewController.swift
//  Dcirrus
//
//  Created by Binesh Pavithran on 27/03/20.
//  Copyright © 2020. All rights reserved.
//

import UIKit

protocol CustomAlertACtionDelegate:class {
    func performAction(_ actionId: Int)
}
class CustomActionSheetViewController: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var buttonsCollectionView: UICollectionView!
    var delegate : CustomAlertACtionDelegate?
    var buttonNames = ["Select All" , "Share" , "Delete" , "Download"]
    var buttonImages = ["select_all" , "share_icon" , "delete_icon" , "download_icon"]
    var intialYPosition : CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUI()
    }
    override func viewWillAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
            self.containerView.frame.origin.y = self.intialYPosition
        }
    }
    func setUI() {
        
        self.containerView.clipsToBounds = true
        self.containerView.layer.cornerRadius = 5
        self.buttonsCollectionView.clipsToBounds = true
        self.intialYPosition = self.containerView.frame.origin.y
        self.containerView.frame.origin.y = self.view.frame.height
    }
}
extension CustomActionSheetViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonNames.count
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let rowCount = CGFloat(buttonNames.count / 2)
        let width = (collectionView.frame.width / rowCount) - 20
        let height = (containerView.frame.height / 2) - 20
        return CGSize(width: width, height:height)
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomActionSheetCollectionViewCell.identifier, for: indexPath) as? CustomActionSheetCollectionViewCell
        cell?.iconImageView.image = UIImage(named: buttonImages[indexPath.row])
        cell?.label.text = buttonNames[indexPath.row]
        return cell ?? UICollectionViewCell()
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIView.animate(withDuration: 0.3, animations: {
            self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
            self.containerView.frame.origin.y = self.view.frame.height
        }) { (_) in
            self.delegate?.performAction(indexPath.row)
            self.dismiss(animated: false, completion: nil)
        }
    }
}
class CustomActionSheetCollectionViewCell : UICollectionViewCell {
    static let identifier = "CustomActionSheetCollectionViewCell"
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var label: UILabel!
}
