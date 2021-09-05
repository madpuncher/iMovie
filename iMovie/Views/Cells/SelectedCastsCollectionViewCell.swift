//
//  SelectedCastsCollectionViewCell.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 04.09.2021.
//

import Foundation

class SelectedCastsCollectionViewCell: UICollectionViewCell {
    
    //MARK: CONSTANTS
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.style = .large
        return indicator
    }()
    
    private let castImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "empty"))
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let castNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let castCharacterLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 14)
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = "castCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        setupConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        castImage.layer.cornerRadius = castImage.bounds.size.height / 2
    }
    //MARK: AUTO LAYOUT
    private func setupConstraints() {
        self.addSubview(castImage)
        self.addSubview(castNameLabel)
        self.addSubview(castCharacterLabel)
        self.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            castImage.heightAnchor.constraint(equalToConstant: castImage.frame.width / 8),
            castImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            castImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            castImage.topAnchor.constraint(equalTo: self.topAnchor),
            
            activityIndicator.heightAnchor.constraint(equalToConstant: self.bounds.height / 1.3),
            activityIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            castNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            castNameLabel.topAnchor.constraint(equalTo: castImage.bottomAnchor, constant: 10),
            castNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            castCharacterLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            castCharacterLabel.topAnchor.constraint(equalTo: castNameLabel.bottomAnchor, constant: 1),
            castCharacterLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2)
            
        ])
    }
    
    //MARK: Конфигурируем свойства представлений на основе модели данных
    func configure(cast: CastMovie) {
        castNameLabel.text = cast.name
        castCharacterLabel.text = cast.character
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(cast.profilePath ?? "")") else { return }
        imageConfigure(url: url)
    }
    
    //MARK: Конфигурируем свойства представлений на основе модели данных
    func configureSerial(cast: CastSerial) {
        castNameLabel.text = cast.name
        castCharacterLabel.text = cast.character
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(cast.profilePath ?? "")") else { return }
        imageConfigure(url: url)
    }
    
    
    func imageConfigure(url: URL) {
        
        castImage.image = nil
        activityIndicator.startAnimating()
        
        ImageDownloadManager.shared.imageLoader(with: url) { image in
            DispatchQueue.main.async { [weak self] in
                if let image = image {
                    
                    self?.castImage.image = image
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
                else {
                    self?.castImage.image = UIImage(named: "empty")
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }}
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: SWIFTUI
import SwiftUI

struct MovieCastCell_Preview: PreviewProvider {
    
    static var previews: some View {
        Container()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> some UIViewController {
            SelectedMovieController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}
