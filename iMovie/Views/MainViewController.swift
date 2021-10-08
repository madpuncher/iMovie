//
//  ViewController.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    //MARK: View constants
    private lazy var views = MainViewControllerViews()
    
    private lazy var searchButton = views.searchButton
    
    private lazy var movieHeaderLabel = views.movieHeaderLabel
    
    private lazy var tvHeaderLabel = views.tvHeaderLabel
    
    private lazy var movieCollectionView = views.movieCollectionView
    
    private lazy var TVCollectionView = views.TVCollectionView
    
    private lazy var headerLabel = views.headerLabel
    
    private let containerView = UIView()
    
    private let scrollView = UIScrollView()
    
    //MARK: View Models
    private var movieViewModel = MovieViewModel()
    
    private var seriesViewModel = SeriesViewModel()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(containerView)
        
        setupUI()
        setupConstraints()
        fetchData()
        
        if !NetworkingManager.shared.isConnectedToNetwork() {
            unableConnect()
        }
    }
    
    func unableConnect() {
        DispatchQueue.main.async { [weak self] in
            let alert = UIAlertController(title: "Ошибка",
                                          message: "Отсутствует подключение к интернету",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Закрыть", style: .default, handler: nil))
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let contentRect: CGRect = containerView.subviews.reduce(into: .zero) { rect, view in
            rect = rect.union(view.frame)
        }
        scrollView.contentSize = contentRect.size
        
        scrollView.frame = view.bounds
        containerView.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: scrollView.contentSize.height)
    }
    
    private func fetchData() {
        movieViewModel.getData { [weak self] in
            self?.movieCollectionView.reloadData()
        }
        seriesViewModel.getData { [weak self] in
            self?.TVCollectionView.reloadData()
        }
    }
    
    //MARK: Custom UI Setup + Delegate and Data Source
    private func setupUI() {
        
        view.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        
        TVCollectionView.delegate = self
        TVCollectionView.dataSource = self
        
        movieCollectionView.showsHorizontalScrollIndicator = false
        TVCollectionView.showsHorizontalScrollIndicator = false
    }
    
    //MARK: Auto layout
    private func setupConstraints() {
        
        containerView.addSubview(headerLabel)
        containerView.addSubview(movieCollectionView)
        containerView.addSubview(movieHeaderLabel)
        containerView.addSubview(TVCollectionView)
        containerView.addSubview(tvHeaderLabel)
        containerView.addSubview(searchButton)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            headerLabel.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 10),
            
            searchButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            searchButton.topAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            movieHeaderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            movieHeaderLabel.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            
            movieCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            movieCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            movieCollectionView.heightAnchor.constraint(equalToConstant: 300),
            movieCollectionView.topAnchor.constraint(equalTo: movieHeaderLabel.bottomAnchor),
            
            tvHeaderLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            tvHeaderLabel.topAnchor.constraint(equalTo: movieCollectionView.bottomAnchor, constant: -20),
            
            TVCollectionView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            TVCollectionView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            TVCollectionView.heightAnchor.constraint(equalToConstant: 300),
            TVCollectionView.topAnchor.constraint(equalTo: tvHeaderLabel.bottomAnchor, constant: -30),
            
            searchButton.heightAnchor.constraint(equalToConstant: 28),
            searchButton.widthAnchor.constraint(equalToConstant: 28)
            
        ])
        
    }
    
}


//MARK: DELEGATE AND DATA SOURCE COLLECTION VIEW
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
            
            let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier,
                                                                    for: indexPath) as! MovieCollectionViewCell
            
            let movie = movieViewModel.cellForRowAt(indexPath: indexPath)
            
            collectionView.configure(movie: movie)
            
            return collectionView
            
        } else {
            
            let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: TVCollectionViewCell.identifier,
                                                                    for: indexPath) as! TVCollectionViewCell
            
            let serie = seriesViewModel.cellForRowAt(indexPath: indexPath)
            
            collectionView.configure(serie: serie)
            
            return collectionView
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if !NetworkingManager.shared.isConnectedToNetwork() {
            unableConnect()
        } else {
            
            if collectionView == movieCollectionView {
                
                let movieVC = SelectedMovieController()
                
                movieVC.configure(movie: movieViewModel.cellForRowAt(indexPath: indexPath), serial: nil)
                movieVC.modalPresentationStyle = .fullScreen
                
                present(movieVC, animated: true, completion: nil)
                
            } else {
                
                let movieVC = SelectedMovieController()
                
                movieVC.serial = true
                movieVC.configure(movie: nil, serial: seriesViewModel.cellForRowAt(indexPath: indexPath))
                movieVC.modalPresentationStyle = .fullScreen
                
                present(movieVC, animated: true, completion: nil)
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == movieCollectionView {
            return CGSize(width: collectionView.frame.width / 2.5, height: collectionView.frame.width / 1.3)
        } else {
            return CGSize(width: collectionView.frame.width / 2.9, height: collectionView.frame.width / 1.7)
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

