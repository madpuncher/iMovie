//
//  SelectedMovieController.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 03.09.2021.
//

import SafariServices
import UIKit

class SelectedMovieController: UIViewController {
    
    //MARK: Constants
    private lazy var views = SelectedViewControllerViews()
    
    private lazy var castCollectionView = views.castCollectionView
    
    private lazy var goBackButton = views.goBackButton
    
    private lazy var saveButton = views.saveButton
    
    private lazy var movieImage = views.movieImage
    
    private lazy var nameLabel = views.nameLabel
    
    private lazy var rateLabel = views.rateLabel
    
    private lazy var infoLabel = views.infoLabel
    
    private lazy var aboutLabel = views.aboutLabel
    
    private lazy var castLabel = views.castLabel
    
    private lazy var stars = views.stars
    
    private lazy var showButton = views.showButton
    
    //MARK: View Models
    private var movieCastViewModel = SelectedMovieViewModel()
    private var serialCastViewModel = SelectedSerialViewModel()
    
    //MARK: CHECK DESTINATION ( MOVIES OR SERIALS )
    var serial: Bool?
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        view.backgroundColor = #colorLiteral(red: 0.08937712759, green: 0.0966457352, blue: 0.1299476326, alpha: 1)
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        goBackButton.layer.cornerRadius = goBackButton.bounds.height / 2
        saveButton.layer.cornerRadius = saveButton.bounds.height / 2
    }
    
    //MARK: Network functions
    private func fetchDataMovie(id: String) {
        movieCastViewModel.getData(id: id) { [weak self] in
            self?.castCollectionView.reloadData()
        }
    }
    
    private func fetchDataSerial(id: String) {
        serialCastViewModel.getData(id: id) { [weak self] in
            self?.castCollectionView.reloadData()
        }
    }
    
    private func getMovie(id: String) {
        if serial != nil {
            serialCastViewModel.getSerialLink(id: id) { [weak self] link in
                if link?.isEmpty == true {
                    DispatchQueue.main.async {
                        self?.showAlertLinkIsEmpty()
                    }
                } else {
                    guard let url = URL(string: link!) else { return }
                    let safari = SFSafariViewController(url: url)
                    safari.modalPresentationStyle = .fullScreen
                    self?.present(safari, animated: true)
                }
            }
        } else {
            movieCastViewModel.getMovieLink(id: id) { [weak self] link in
                if link?.isEmpty == true {
                    DispatchQueue.main.async {
                        self?.showAlertLinkIsEmpty()
                    }
                } else {
                    guard let url = URL(string: link!) else { return }
                    let safari = SFSafariViewController(url: url)
                    safari.modalPresentationStyle = .fullScreen
                    self?.present(safari, animated: true)
                }
            }
        }
    }
    
    //MARK: UI Configure
    private func setupUI() {
        
        castCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.showsHorizontalScrollIndicator = false
        
        goBackButton.addTarget(self, action: #selector(goBackButtonTapped), for: .touchUpInside)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        showButton.addTarget(self, action: #selector(showButtonTapped), for: .touchUpInside)
    }
    
    //MARK: ALERTS
    private func showAlertLinkIsEmpty() {
        let alert = UIAlertController(title: "Oops...", message: "Apparently, there is no website for this movie 🥲", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    //MARK: AUTO LAYOUT
    private func setupConstraints() {
        view.addSubview(movieImage)
        view.addSubview(goBackButton)
        view.addSubview(saveButton)
        view.addSubview(nameLabel)
        view.addSubview(infoLabel)
        view.addSubview(aboutLabel)
        view.addSubview(castLabel)
        view.addSubview(castCollectionView)
        view.addSubview(stars)
        view.addSubview(showButton)
        
        let starStackView = UIStackView(arrangedSubviews: [rateLabel, stars])
        starStackView.translatesAutoresizingMaskIntoConstraints = false
        starStackView.axis = .horizontal
        starStackView.spacing = 10
        
        view.addSubview(starStackView)
        
        NSLayoutConstraint.activate([
            movieImage.topAnchor.constraint(equalTo: view.topAnchor),
            movieImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            movieImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            movieImage.heightAnchor.constraint(equalToConstant: view.bounds.height / 2),
            
            goBackButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            goBackButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            goBackButton.heightAnchor.constraint(equalToConstant: 35),
            goBackButton.widthAnchor.constraint(equalToConstant: 35),
            
            saveButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            saveButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            saveButton.heightAnchor.constraint(equalToConstant: 35),
            saveButton.widthAnchor.constraint(equalToConstant: 35),
            
            nameLabel.bottomAnchor.constraint(equalTo: movieImage.bottomAnchor, constant: -5),
            nameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            infoLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            starStackView.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 15),
            starStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            aboutLabel.topAnchor.constraint(equalTo: starStackView.bottomAnchor, constant: 15),
            aboutLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            aboutLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            castLabel.topAnchor.constraint(equalTo: aboutLabel.bottomAnchor, constant: 10),
            castLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            castCollectionView.topAnchor.constraint(equalTo: castLabel.bottomAnchor, constant: 10),
            castCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            castCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            castCollectionView.heightAnchor.constraint(equalToConstant: 150),
            
            showButton.topAnchor.constraint(equalTo: castCollectionView.bottomAnchor, constant: 10),
            showButton.widthAnchor.constraint(equalToConstant: view.bounds.width / 2),
            showButton.heightAnchor.constraint(equalToConstant: 50),
            showButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
    }
    
    //MARK: GET DATA FROM NETWORK MOVIEW OR SERIAL VIEWS
    func configure(movie: Movie?, serial: Series?) {
        if let movieNotNil = movie {
            NetworkingManager.shared.fetchMovieDetail(id: String(describing: movieNotNil.id)) { [weak self] response in
                switch response {
                
                case .success(let details):
                    self?.fetchDataMovie(id: String(describing: details.id))
                    guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(details.backdropPath!)") else { return }
                    let gengres = details.genres.prefix(2).compactMap{ $0.name }.joined(separator: ", ")
                    self?.imageConfigure(url: url)
                    self?.nameLabel.text = details.originalTitle
                    self?.infoLabel.text = "\(details.releaseDate.convertDate()) • \(gengres) • \(details.runtime.secondsToHoursMinutesSeconds())"
                    self?.rateLabel.text = String(describing: details.voteAverage)
                    self?.stars.rating = details.voteAverage / 2
                    
                    if details.overview.isEmpty {
                        self?.aboutLabel.text = "Описание к данному фильму отсутствует"
                    } else {
                        self?.aboutLabel.text = details.overview
                    }
                              
                    self?.movieCastViewModel.selectedMovieId = String(describing: details.id)
                    
                case .failure(let error):
                    print(error)
                }
            }
        } else {
            
            if let serialNotNil = serial {
                
                NetworkingManager.shared.fetchSerialDetail(id: String(describing: serialNotNil.id)) { [weak self] response in
                    switch response {
                    case .success(let details):
                        print("Serial")
                        self?.fetchDataSerial(id: String(describing: details.id))
                        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(details.backdropPath!)") else { return }
                        let gengres = details.genres.prefix(2).compactMap{ $0.name }.joined(separator: ", ")
                        self?.imageConfigure(url: url)
                        self?.nameLabel.text = details.name
                        self?.stars.rating = details.voteAverage / 2
                        
                        if let runTime = details.episodeRunTime?.first {
                            self?.infoLabel.text = "\(details.firstAirDate.convertDate()) • \(gengres) • \(runTime.secondsToHoursMinutesSeconds())"
                        } else {
                            self?.infoLabel.text = "\(details.firstAirDate.convertDate()) • \(gengres) • Time unknown"
                        }
                        self?.rateLabel.text = String(describing: details.voteAverage)
                        if details.overview.isEmpty {
                            self?.aboutLabel.text = "Описание к данному сериалу отсутствует"
                        } else {
                            self?.aboutLabel.text = details.overview
                        }
                        
                        self?.serialCastViewModel.selectedSerialId = String(describing: details.id)
                        
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
    
    //MARK: IMAGE DOWNLOADER
    func imageConfigure(url: URL) {
        ImageDownloadManager.shared.imageLoader(with: url) { image in
            if let image = image {
                DispatchQueue.main.async { [weak self] in
                    self?.movieImage.image = image
                }
            }
        }
    }
    
    //MARK: BUTTON ACTIONS
    @objc private func goBackButtonTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        saveButton.tintColor = .yellow
    }
    
    @objc private func showButtonTapped() {
        if serial != nil {
            getMovie(id: serialCastViewModel.selectedSerialId ?? "")
        } else {
            getMovie(id: movieCastViewModel.selectedMovieId ?? "")
        }
    }
}

//MARK: DELEGATE AND DATA SOURCE COLLECTION VIEW
extension SelectedMovieController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if serial != nil {
            return serialCastViewModel.numbersOfRows()
        } else {
            return movieCastViewModel.numbersOfRows()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let collectionView = collectionView.dequeueReusableCell(withReuseIdentifier: SelectedCastsCollectionViewCell.identifier, for: indexPath) as! SelectedCastsCollectionViewCell
        
        if serial != nil {
            
            collectionView.configureSerial(cast: serialCastViewModel.cellForRowAt(indexPath: indexPath))
            
        } else {
            
            collectionView.configure(cast: movieCastViewModel.cellForRowAt(indexPath: indexPath))
        }
        
        return collectionView
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width / 3, height: collectionView.frame.width / 3)
    }
}

//MARK: SWIFTUI
import SwiftUI

struct SelectedMovieController_Preview: PreviewProvider {
    
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
