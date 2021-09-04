//
//  ViewController.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private let searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "loupe"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.tintColor = .white
        button.layer.shadowColor = UIColor.black.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let movieHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "Popular movie"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let tvHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "TV Show"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 23)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let movieCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        collection.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let TVCollectionView: UICollectionView = {
        let flow = UICollectionViewFlowLayout()
        flow.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: flow)
        collection.register(TVCollectionViewCell.self, forCellWithReuseIdentifier: TVCollectionViewCell.identifier)
        collection.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        collection.translatesAutoresizingMaskIntoConstraints = false
        return collection
    }()
    
    private let headerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.halfTextColorChange(fullText: "Эльдар", changeText: "ар")
        label.font = .boldSystemFont(ofSize: 40)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var movieViewModel = MovieViewModel()
    private var seriesViewModel = SeriesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        fetchData()
    }
    
    private func fetchData() {
        movieViewModel.getData { [weak self] in
            self?.movieCollectionView.reloadData()
        }
        seriesViewModel.getData { [weak self] in
            self?.TVCollectionView.reloadData()
        }
    }
    
    private func setupUI() {
        
        view.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        TVCollectionView.delegate = self
        TVCollectionView.dataSource = self
        
        movieCollectionView.showsHorizontalScrollIndicator = false
        TVCollectionView.showsHorizontalScrollIndicator = false
    }
    
    private func setupConstraints() {
        
        view.addSubview(headerLabel)
        view.addSubview(movieCollectionView)
        view.addSubview(movieHeaderLabel)
        view.addSubview(TVCollectionView)
        view.addSubview(tvHeaderLabel)
        view.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            searchButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            searchButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            movieHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieHeaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            
            movieCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            movieCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            movieCollectionView.heightAnchor.constraint(equalToConstant: 300),
            movieCollectionView.topAnchor.constraint(equalTo: movieHeaderLabel.bottomAnchor),
            
            tvHeaderLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            tvHeaderLabel.topAnchor.constraint(equalTo: movieCollectionView.bottomAnchor, constant: 0),
            
            TVCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            TVCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            TVCollectionView.heightAnchor.constraint(equalToConstant: 300),
            TVCollectionView.topAnchor.constraint(equalTo: tvHeaderLabel.bottomAnchor, constant: -30),
            
            searchButton.heightAnchor.constraint(equalToConstant: 28),
            searchButton.widthAnchor.constraint(equalToConstant: 28)
            
        ])
        
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == movieCollectionView {
            return movieViewModel.numbersOfRows()
        } else {
            return seriesViewModel.numbersOfRows()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == movieCollectionView {
            
            let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as! MovieCollectionViewCell
                        
            let movie = movieViewModel.cellForRowAt(indexPath: indexPath)
            
            collectionView.configure(movie: movie)
            
            return collectionView
            
        } else {
            
            let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier, for: indexPath) as! TVCollectionViewCell
            
            let serie = seriesViewModel.cellForRowAt(indexPath: indexPath)
            
            collectionView.configure(serie: serie)
            
            return collectionView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == movieCollectionView {
            let movieVC = SelectedMovieController()
            movieVC.configure(movie: movieViewModel.cellForRowAt(indexPath: indexPath))
            movieVC.modalPresentationStyle = .fullScreen
            present(movieVC, animated: true, completion: nil)
        } else {
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == movieCollectionView {
            return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.width / 1.3)
        } else {
            return CGSize(width: collectionView.frame.width / 2.9, height: collectionView.frame.width / 1.6)
        }
    }
}

//MARK: SWIFTUI
import SwiftUI

struct MainViewController_Preview: PreviewProvider {
    
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
