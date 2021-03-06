//
//  SelectedViewControllerViews.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 05.09.2021.
//

import UIKit
import Cosmos

final class SelectedViewControllerViews {
    
    public let containerView = UIView()
    
    public let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
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
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.1889515672)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "save"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        button.tintColor = .white
        button.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 0.1889515672)
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
        label.textColor = #colorLiteral(red: 0.9853249192, green: 0.7781492472, blue: 0.2004194856, alpha: 1)
        label.font = .boldSystemFont(ofSize: 19)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let infoLabel: UILabel = {
        let label = UILabel()
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
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 0
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
    
    public let stars: CosmosView = {
        let view = CosmosView()
        view.settings.updateOnTouch = false
        view.settings.filledColor = #colorLiteral(red: 0.9853249192, green: 0.7781492472, blue: 0.2004194856, alpha: 1)
        view.settings.emptyColor = .gray
        view.settings.filledBorderColor = #colorLiteral(red: 0.9853249192, green: 0.7781492472, blue: 0.2004194856, alpha: 1)
        view.settings.emptyBorderColor = .gray
        view.settings.starSize = 20
        view.settings.starMargin = 4
        return view
    }()
    
    public let showButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Watch Now", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = #colorLiteral(red: 0.8895335793, green: 0.1325577796, blue: 0.2192041278, alpha: 1)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
}

