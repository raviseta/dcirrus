//
//  CollectionViewDataSource.swift
//  Dcirrus
//
//  Created by raviseta on 03/02/21.
//  Copyright © 2021 Goodbits. All rights reserved.
//

import Foundation
import UIKit

class CollectionViewDataSource<Cell : UICollectionViewCell,ViewModel> : NSObject , UICollectionViewDataSource {

    private var items :[ViewModel]!

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
}
