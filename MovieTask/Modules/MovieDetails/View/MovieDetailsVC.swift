//
//  MovieDetailsVC.swift
//  MovieTask
//
//  Created by Al-attar on 30/03/2024.
//

import UIKit
import youtube_ios_player_helper

class MovieDetailsVC: BaseWireFrame<MovieDetailsViewModel> {

    //MARK: - @IBOutlet
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var rateLabel: UILabel!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var descripationLable: UILabel!
    @IBOutlet weak var trailerViedo: YTPlayerView!
    @IBOutlet weak var castCollectionView: UICollectionView!
    
    override func bind(viewModel: MovieDetailsViewModel) {
        viewModel.movieGenres.bind { [weak self] genres in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateGenresLabel(with: genres)
            }
        }
        
        viewModel.cast.bind { [weak self] _ in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.castCollectionView.reloadData()
            }
        }
        
        viewModel.videoKey.bind { [weak self] key in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.trailerViedo.load(withVideoId: key)
            }
        }
        
        viewModel.viewDidLoad()
        setupUI()
        setupCollectionView()
    }
    
    //MARK: - Private func
    private func setupUI() {
        let poster = "https://image.tmdb.org/t/p/w342/\(viewModel.movieDetails.poster_path ?? "")"
        let posterURL = URL(string: poster)
        let roundedVoteAverage = (viewModel.movieDetails.vote_average * 10).rounded() / 10
        
        posterImage.setImage(with: posterURL)
        rateLabel.text = "\(roundedVoteAverage)"
        movieNameLabel.text = viewModel.movieDetails.title
        descripationLable.text = viewModel.movieDetails.overview
    }
    
    private func updateGenresLabel(with genres: [String]) {
        genresLabel.text = genres.joined(separator: ", ")
    }
    
    private func setupCollectionView() {
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        castCollectionView.registerNIB(CastCell.self)
    }
    
    //MARK: - @IBAction    
    @IBAction func backTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}

//MARK: - Collection View Delegation and Data Source
extension MovieDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfChartacters()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: CastCell.self, for: indexPath)
        viewModel.configrationCell(cell, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width / 3 ), height: 170)
    }
}
