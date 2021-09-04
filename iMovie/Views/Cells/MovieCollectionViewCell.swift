//
//  MovieCollectionViewCell.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    //MARK: CONSTANTS
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.color = .white
        indicator.style = .large
        return indicator
    }()
    
    private let movieImage: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.layer.cornerRadius = 15
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = .boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static let identifier = "movieCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    
        self.contentView.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        setupConstraints()
    }
    
    //MARK: AUTO LAYOUT
    private func setupConstraints() {
        self.addSubview(movieImage)
        self.addSubview(movieNameLabel)
        self.addSubview(movieDateLabel)
        self.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            movieImage.heightAnchor.constraint(equalToConstant: self.bounds.height / 1.3),
            movieImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            activityIndicator.heightAnchor.constraint(equalToConstant: self.bounds.height / 1.3),
            activityIndicator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            movieNameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieNameLabel.topAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: 10),
            movieNameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            
            movieDateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            movieDateLabel.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 1),

        ])
    }
    
    //MARK: Конфигурируем свойства представлений на основе модели данных
    func configure(movie: Movie) {
        movieNameLabel.text = movie.originalTitle
        movieDateLabel.text = converDate(forDate: movie.releaseDate)
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(movie.backdropPath)") else { return }
        imageConfigure(url: url)
    }
    
    func imageConfigure(url: URL) {
        
        movieImage.image = nil
        activityIndicator.startAnimating()
        
        ImageDownloadManager.shared.imageLoader(with: url) { image in
            if let image = image {
                DispatchQueue.main.async { [weak self] in
                    self?.movieImage.image = image
                    self?.activityIndicator.stopAnimating()
                    self?.activityIndicator.isHidden = true
                }
            }
        }
    }
    
    //MARK: Конвертируем дату в необходимый вид
    private func converDate(forDate date: String) -> String {
        
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let showDate = inputFormatter.date(from: date) else { return "2020-02-02"}
        
        inputFormatter.dateFormat = "MMM d, yyyy"
        
        let resultString = inputFormatter.string(from: showDate)
        
        return resultString
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: SWIFTUI
import SwiftUI

struct MovieCell_Preview: PreviewProvider {
    
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
