//
//  Series.swift
//  iMovie
//
//  Created by Eʟᴅᴀʀ Tᴇɴɢɪᴢᴏᴠ on 02.09.2021.
//

import Foundation

//MARK: MAIN MENU INFO RESPONSE
struct SeriesResponse: Codable {
    
    let results: [Series]
}

struct Series: Codable {
    let backdropPath: String?
    let firstAirDate: String
    let genreIDS: [Int]
    let id: Int
    let name: String
    let originCountry: [String]
    let originalLanguage: String
    let originalName: String
    let overview: String
    let popularity: Double
    let posterPath: String
    let voteAverage: Double
    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIDS = "genre_ids"
        case id, name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}
//MARK: DETAILS
struct SerialDetailResponse: Codable {
    let backdropPath: String?
    let episodeRunTime: [Int]?
    let firstAirDate: String
    let genres: [Genre]
    let id: Int
    let name: String
    let overview: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case episodeRunTime = "episode_run_time"
        case genres
        case id
        case name
        case firstAirDate = "first_air_date"
        case overview
        case voteAverage = "vote_average"
    }
}

struct Genre: Codable {
    let id: Int
    let name: String
}

//MARK: CASTS
struct SerialCasts: Codable {
    let cast: [CastSerial]
}

struct CastSerial: Codable {
    let name: String
    let profilePath: String?
    let character: String?


    enum CodingKeys: String, CodingKey {
        case name
        case profilePath = "profile_path"
        case character
    }
}

//MARK: VIDEO

struct SerieVideo: Codable {
    
    let id: Int
    let results: SerieResults
}

struct SerieResults: Codable {

    let us: MovieLink

    enum CodingKeys: String, CodingKey {
        case us = "US"
    }
}

struct SerieLink: Codable {
    let link: String?
}

