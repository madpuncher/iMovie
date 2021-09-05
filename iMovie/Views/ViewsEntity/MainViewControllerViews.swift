//
//  Views.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 05.09.2021.
//

import UIKit

final class MainViewControllerViews {
    public let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "loupe"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    public let movieHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular movie"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let tvHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "TV Show"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let movieCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collection.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    public let TVCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        collection.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    public let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.halfTextColorChange(fullText: "Эльдар", changeText: "ар")
        label.font = .boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}

