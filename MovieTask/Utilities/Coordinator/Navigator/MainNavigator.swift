//
//  MainNavigator.swift
//  MovieTask
//
//  Created by Al-attar on 28/03/2024.
//

import Foundation
import UIKit

class MainNavigator: Navigator {
    
    var coordinator: Coordinator
    
    
    enum Destination {
        case nowPlaying
        case MovieDetails(movieDetails: MovieDetailsModel)
    }
    
    required init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }
    
    
    func viewcontroller(for destination: Destination) -> UIViewController {
        switch destination {
        case .nowPlaying:
            let movieRepo = MovieWorker()
            let viewModel = NowPlayingViewModel(movies: movieRepo)
            return NowPlayingVC(viewModel: viewModel, coordinator: coordinator)
        case .MovieDetails(let movieDetails):
            let trailerRepo = TrailerWorker()
            let genresRepo = GenresWorker()
            let castRepo = CastWorker()
            let viewModel = MovieDetailsViewModel(
                movieDetails: movieDetails,
                trailerRepo: trailerRepo,
                castRepo: castRepo,
                genresRepo: genresRepo
            )
            return MovieDetailsVC(viewModel: viewModel, coordinator: coordinator)
        }
    }
}
