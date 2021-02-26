//
//  DownloadsTableView.swift
//  Dcirrus
//
//  Created by Gaadha on 19/09/19.
//  Copyright © 2019 Goodbits. All rights reserved.
//

import UIKit
import SwipeCellKit

class DownloadsViewController :  UIViewController,UIGestureRecognizerDelegate {
    
    enum FolderActions : Int {
        case selectAll
        case share
        case delete
        case download
    }
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var m_tblviewDownloads: UITableView!
    var isMultipleSelectionStarted = false
    var selectedIndexPaths = [IndexPath]()
    override func viewDidLoad() {
        
        super.viewDidLoad()
        m_tblviewDownloads.dataSource = self
        m_tblviewDownloads.delegate = self
        let xibdownloadsTableViewCell = UINib(nibName: "DownloadsTableViewCell", bundle: Bundle.main)
        self.m_tblviewDownloads.register(xibdownloadsTableViewCell, forCellReuseIdentifier: "cell")
        self.setupLongPressGesture()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.setUI()
    }

    func setUI() {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.title = "Downloads"
        addSearchButton()
        let titleLabel = Utilities.titleLabel()
        titleLabel.text = "Downloads"
        navigationItem.titleView = titleLabel
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
    func setupLongPressGesture() {
        let longPressGesture:UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.handleLongPress))
        longPressGesture.minimumPressDuration = 1.0 // 1 second press
        longPressGesture.delegate = self
        self.m_tblviewDownloads.addGestureRecognizer(longPressGesture)
    }
    
    @objc func handleLongPress(_ gestureRecognizer: UILongPressGestureRecognizer){
        if gestureRecognizer.state == .began {
            let touchPoint = gestureRecognizer.location(in: self.m_tblviewDownloads)
            if let indexPath = m_tblviewDownloads.indexPathForRow(at: touchPoint) {
                isMultipleSelectionStarted = true
                selectedIndexPaths.append(indexPath)
                m_tblviewDownloads.reloadData()
            }
        }
    }
    @objc func searchButtonPressed() {
        print("searchButtonPressed")
        self.navigationItem.rightBarButtonItem = nil
        self.addSearchBar()
    }
    @IBAction func moreButtonAction(_ sender: UIButton) {
        selectedIndexPaths = [IndexPath]()
        var buttonNames = ["Take Picture" , "Photo Gallery" , "File Manager" , "Scan Document"]
        var buttonImages = ["camera" , "photo_gallery" , "file_manager" , "scan_doc"]
        if isMultipleSelectionStarted {
            buttonNames = ["Select All" , "Share" , "Download" ,"Move","Copy","Delete"]
            buttonImages = ["select_all" , "share_icon" , "download_icon", "move_icon" , "copy", "delete_icon"]
        }
        Utilities.showCustomActionSheet(buttonNames: buttonNames, buttonImages: buttonImages, presentingView: self)
    }
    @IBAction func sortButtonAction(_ sender: UIButton) {
        
        
    }
    
}
extension DownloadsViewController : CustomAlertACtionDelegate {
    func performAction(_ actionId: Int) {
        if isMultipleSelectionStarted {
            if let folderAction = FolderActions(rawValue : actionId) {
                if folderAction == .share {
                    self.showShareScreen()
                }
            }
            self.isMultipleSelectionStarted = false
        }
        self.m_tblviewDownloads.reloadData()
        
    }
    func showShareScreen() {
        let controller = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShareViewViewController")
        self.navigationController?.pushViewController (controller, animated: true)
    }
}
extension DownloadsViewController : UISearchBarDelegate {
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
extension DownloadsViewController :  UITableViewDataSource , UITableViewDelegate {
    //tableView Delegate and Datasource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.m_tblviewDownloads.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! DownloadsTableViewCell
        cell.delegate = self
        cell.selectionStyle = .none
        cell.m_imgfile.image = selectedIndexPaths.contains(indexPath) ? UIImage(named: "green_tick") : UIImage(named: "jpeg_file")
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isMultipleSelectionStarted {
            let cell = tableView.cellForRow(at: indexPath) as? DownloadsTableViewCell
            cell?.m_imgfile.image = UIImage(named: "green_tick")
            selectedIndexPaths.append(indexPath)
        }
    }
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? DownloadsTableViewCell
        cell?.m_imgfile.image = UIImage(named: "jpeg_file")
        if let index = selectedIndexPaths.firstIndex(of: indexPath) {
            selectedIndexPaths.remove(at: index)
        }
        if selectedIndexPaths.count == 0 {
            isMultipleSelectionStarted = false
        }
    }
}
extension DownloadsViewController : SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        return [self.getSwipeButton(title: "Delete", imageName: "delete_white") , self.getSwipeButton(title: "Download", imageName: "download_white") , self.getSwipeButton(title: "Share", imageName: "share_white") , self.getSwipeButton(title: "Rename", imageName: "delete_white")]
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
