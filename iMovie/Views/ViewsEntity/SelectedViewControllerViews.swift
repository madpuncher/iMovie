//
//  SelectedViewControllerViews.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 05.09.2021.
//

import UIKit

final class SelectedViewControllerViews {
    
    public let castCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.register(SelectedCastsCollectionViewCell.self, forCellWithReuseIdentifier: SelectedCastsCollectionViewCell.identifier)
        collection.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    public let goBackButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.4481212236)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "save"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.4481212236)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    public let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Wonder Woman"
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.layer.shadowColor = UIColor.black.cgColor
        label.layer.shadowRadius = 3.0
        label.layer.shadowOpacity = 1.0
        label.layer.shadowOffset = CGSize(width: 4, height: 4)
        label.layer.masksToBounds = false
        return label
    }()
    
    public let rateLabel: UILabel = {
        let label = UILabel()
        label.text = "7.9"
        label.textColor = #colorLiteral(red: 0.9853249192, green: 0.7781492472, blue: 0.2004194856, alpha: 1)
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let infoLabel: UILabel = {
        let label = UILabel()
        label.text = "2020 • Adventure, Action • 2h 35m"
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 17)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let aboutLabel: UILabel = {
        let label = UILabel()
        label.text = "BLALALALALALALALALALALDSLDSALSADLDSLDSALDLSLSDALSDALSDLDSALDSALSDALLDS"
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let castLabel: UILabel = {
        let label = UILabel()
        label.text = "Cast"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

