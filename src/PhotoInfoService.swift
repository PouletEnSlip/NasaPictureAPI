//
//  PhotoInfoService.swift
//  NasaPhoto
//
//
//

import Foundation

struct PhotoInfoService {
    enum PhotoInfoError: Error {
        case failed
        case failedToDecode
        case invalideStatusCode
    }
    
    func fetchPhotoInfo() async throws -> PhotoInfo {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let todayString = formatter.string(from: today)
        let urlString = "https://api.nasa.gov/planetary/apod?api_key=YOUR_KEY&date=\(todayString)"
        let url = URL(string: urlString)!
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse,
            response.statusCode == 200 else {
                throw PhotoInfoError.invalideStatusCode
        }
        
        let decodeData = try JSONDecoder().decode(PhotoInfo.self, from: data)
        
        return decodeData
    }
}
