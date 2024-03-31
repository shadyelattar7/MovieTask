//
//  MovieCache.swift
//  MovieTask
//
//  Created by Al-attar on 31/03/2024.
//

import Foundation
import CoreData

class MovieCache {
    static let shared = MovieCache()
    
    private init() {}
    
    func saveMovies(_ movies: [MovieData]) {
        let context = CoreDataStack.shared.context
        for movieModel in movies {
            let movie = Movie(context: context)
            movie.id = Int32(movieModel.id)
            movie.title = movieModel.title
            movie.overview = movieModel.overview
            movie.poster = movieModel.poster_path
            movie.rate = movieModel.vote_average
            movie.date = movieModel.release_date
        }
        CoreDataStack.shared.saveContext()
    }
    
    func loadMovies() -> [MovieData] {
        let context = CoreDataStack.shared.context
        let fetchRequest: NSFetchRequest<Movie> = Movie.fetchRequest()
        do {
            let movies = try context.fetch(fetchRequest)
            let movieDataArray = movies.map { movie in
                return MovieData(
                    id: Int(movie.id),
                    title: movie.title ?? "" ,
                    overview: movie.overview ?? "",
                    poster_path: movie.poster,
                    backdrop_path: "",
                    vote_average: movie.rate,
                    release_date: movie.date ?? "",
                    original_title: ""
                )
            }
            return movieDataArray
        } catch {
            print("Error fetching movies: \(error.localizedDescription)")
            return []
        }
    }
}
