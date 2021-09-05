//
//  Movie.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import Foundation

//MARK: MAIN MENU INFO RESPONSE
struct MovieResponse: Codable {
    
    let results: [Movie]
}

struct Movie: Codable {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let releaseDate: String
    let title: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case genreIDS = "genre_ids"
        case id
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview, popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case title, video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

//MARK: DETAILS
struct MovieDetailsResponse: Codable {
    
    let backdropPath: String?
    let genres: [GenreMovies]
    let originalTitle: String
    let overview: String
    let releaseDate: String
    let runtime: Int
    let id: Int
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case genres
        case id
        case originalTitle = "original_title"
        case overview
        case releaseDate = "release_date"
        case runtime
        case voteAverage = "vote_average"
    }
}

struct GenreMovies: Codable {
    let id: Int
    let name: String
}

//MARK: CAST
struct MovieCasts: Codable {
    let cast: [CastMovie]
}

struct CastMovie: Codable {
    let name: String
    let profilePath: String?
    let character: String

    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}

//MARK: VIDEO

struct MovieVideo: Codable {
    
    let id: Int
    let results: Results
}

struct Results: Codable {

    let us: MovieLink

    enum CodingKeys: String, CodingKey {
        case us = "US"
    }
}

struct MovieLink: Codable {
    let link: String?
}

