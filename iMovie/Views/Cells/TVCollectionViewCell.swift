//
//  TVCollectionViewCell.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import UIKit

class TVCollectionViewCell: UICollectionViewCell {
    
    //MARK: CONSTANTS
    private let imageTV: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.style = .large
        return indicator
    }()
    
    private let nameTVLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dateTVLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = "tvCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.contentView.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        
        setupConstraints()
    }
    
    //MARK: AUTO LAYOUT
    private func setupConstraints() {
        self.addSubview(imageTV)
        self.addSubview(activityIndicator)
        self.addSubview(nameTVLabel)
        self.addSubview(dateTVLabel)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            imageTV.heightAnchor.constraint(equalToConstant: self.bounds.height / 1.3),
            imageTV.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            imageTV.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            activityIndicator.heightAnchor.constraint(equalToConstant: self.bounds.height / 1.3),
            activityIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            nameTVLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            nameTVLabel.topAnchor.constraint(equalTo: imageTV.bottomAnchor, constant: 10),
            nameTVLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            dateTVLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            dateTVLabel.topAnchor.constraint(equalTo: nameTVLabel.bottomAnchor, constant: 1),
        ])
        
    }
    
    //MARK: Конфигурируем свойства представлений на основе модели данных
    func configure(serie: Series) {
        nameTVLabel.text = serie.originalName
        dateTVLabel.text = serie.firstAirDate.convertDate()
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(serie.backdropPath ?? "")") else { return }
        imageConfigure(url: url)
    }
    
    func imageConfigure(url: URL) {
        
        activityIndicator.startAnimating()
        
        ImageDownloadManager.shared.imageLoader(with: url) { image in
            DispatchQueue.main.async { [weak self] in
                
                if let image = image {
                    
                    self?.imageTV.image = image
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                    
                } else {
                    
                    self?.imageTV.image = UIImage(named: "empty")
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: SWIFTUI
import SwiftUI

struct TVCell_Preview: PreviewProvider {
    
    static var previews: some View {
        Container()
            .edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        
        func makeUIViewController(context: Context) -> some UIViewController {
            MainViewController()
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
            
        }
    }
}

