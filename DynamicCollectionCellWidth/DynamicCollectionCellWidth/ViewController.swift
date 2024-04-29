//
//  ViewController.swift
//  DynamicCollectionCellWidth
//
//  Created by mac on 25/04/24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var collectionView: UICollectionView!
    var items = ["Free", "Available","DC Fast", "Connector","First"]
    lazy var fontSize = view.frame.height * 17/852
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: ListCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: ListCollectionViewCell.identifier)
        
    }
    

}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ListCollectionViewCell.identifier, for: indexPath) as! ListCollectionViewCell
        cell.listLabel.text = items[indexPath.row]
        cell.listLabel.font = .systemFont(ofSize: fontSize)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellHeight = collectionView.frame.height - 10
        let cellWidth = estimateLabelWidth(text: items[indexPath.row], font: .systemFont(ofSize: fontSize))
        
        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func estimateLabelWidth(text: String, font: UIFont) -> CGFloat {
        let label = UILabel()
        label.font = font
        label.text = text
        label.sizeToFit()
        return label.frame.width + 30
        
    }
    
}

