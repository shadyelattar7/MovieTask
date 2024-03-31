//
//  NowPlayingVC.swift
//  MovieTask
//
//  Created by Al-attar on 28/03/2024.
//

import UIKit

class NowPlayingVC: BaseWireFrame<NowPlayingViewModel> {
    
    //MARK: - Properties
    private let cellScaling: CGFloat = 0.6
    
    //MARK: - @IBOutlet
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    //MARK: - Bind
    override func bind(viewModel: NowPlayingViewModel) {
        viewModel.viewDidLoad()
        
        viewModel.movies.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.movieCollectionView.reloadData()
            }
        }
        
        setupCollectionView()
    }
    

    
    private func setupCollectionView() {
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
        movieCollectionView.registerNIB(MovieCell.self)
        customLayout()
    }
}

//MARK: - Collection View Delegation and Data Source
extension NowPlayingVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeue(cell: MovieCell.self, for: indexPath)
        viewModel.configrationCell(cell, index: indexPath.row)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = self.viewModel.getMovieDataModel(indexPath.row)
        
        self.coordinator.Main.navigate(
            for: .MovieDetails(
                movieDetails: MovieDetailsModel(
                    id: movie.id,
                    title: movie.title,
                    overview: movie.overview,
                    poster_path: movie.poster_path,
                    vote_average: movie.vote_average
                )
            )
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 230, height: 400)
    }
    
    func customLayout(){
        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)
        
        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0
        
        let layout = movieCollectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        movieCollectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)
        
    }
}

extension NowPlayingVC: UIScrollViewDelegate{
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.movieCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
        
    }
}
