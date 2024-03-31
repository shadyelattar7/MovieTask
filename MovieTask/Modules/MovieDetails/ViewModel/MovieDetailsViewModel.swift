//
//  MovieDetailsViewModel.swift
//  MovieTask
//
//  Created by Al-attar on 30/03/2024.
//

import Foundation

//MARK: - ViewController -> ViewModel
protocol MovieDetailsInputs{
    func viewDidLoad()
}


//MARK: - ViewController <- ViewModel
protocol MovieDetailsOutputs{
    func numberOfChartacters() -> Int
}

class MovieDetailsViewModel: BaseViewModel, MovieDetailsInputs, MovieDetailsOutputs {
    
    //MARK: - Puplic Properties
    var movieDetails: MovieDetailsModel
    var trailer: Box<[VideoDetails]> = Box([])
    var cast: Box<[CastDetails]> = Box([])
    var genresId: Box<[GenresDetails]> = Box([])
    var movieGenres: Box<[String]> = Box([])
    var videoKey: Box<String> = Box("")
    
    //MARK: - Private Properties
    private let trailerRepo: TrailerWorkerProtocol
    private let castRepo: CastWorkerProtocol
    private let genresRepo: GenresWorkerProtocol
    
    //MARK: - Init
    init(
        movieDetails: MovieDetailsModel,
        trailerRepo: TrailerWorkerProtocol,
        castRepo: CastWorkerProtocol,
        genresRepo: GenresWorkerProtocol
    ) {
        self.movieDetails = movieDetails
        self.trailerRepo = trailerRepo
        self.castRepo = castRepo
        self.genresRepo = genresRepo
    }
    
    //MARK: - Inputs
    func viewDidLoad() {
        getTrailer()
        getGenres()
        getCast()
    }
    
    // MARK: - Outputs
    func numberOfChartacters() -> Int {
        return cast.value.count
    }
    
    // MARK: - API Calls
    private func getTrailer() {
        trailerRepo.trailer(id: movieDetails.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let trailer):
                self.trailer.value = trailer.results
                self.videoKey.value = self.trailer.value.first?.key ?? ""
            case .failure(let error):
                print("Error fetching trailer:", error)
            }
        }
    }
    
    private func getCast() {
        castRepo.cast(id: movieDetails.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let cast):
                self.cast.value = cast.cast
            case .failure(let error):
                print("Error fetching cast:", error)
            }
        }
    }
    
    private func getGenres() {
        genresRepo.genres(id: movieDetails.id) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let genres):
                self.genresId.value = genres.genres
                self.movieGenres.value = self.genresId.value.map { $0.name }
            case .failure(let error):
                print("Error fetching genres:", error)
            }
        }
    }
    
    // MARK: - configration Cell
    func configrationCell( _ cell : CastCell , index : Int){
        let modelOfCell = cast.value[index]
        let poster = "https://image.tmdb.org/t/p/w342/\(modelOfCell.profile_path ?? "")"
        
        let castCellAdapter = CastCellAdapter(
            character: modelOfCell.character,
            name: modelOfCell.name,
            profile_path: poster
        )
        cell.configuration(viewModel: castCellAdapter)
    }
}
