//
//  PhotoInfoViewModel.swift
//  NasaPhoto
//
//
//

import Foundation

class PhotoInfoViewModel: ObservableObject {
    enum State {
        case notAvailable
        case loading
        case success(data: PhotoInfo)
        case failed(error: Error)
    }
    
    private let service = PhotoInfoService()
    
    @Published var state: State = .notAvailable
    @Published var hasError: Bool = false
    
    func getPhotoInfo() async {
        self.state = .loading
        self.hasError = false
        do {
            let photoInfo = try await service.fetchPhotoInfo()
            self.state = .success(data: photoInfo)
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
            print(error)
        }
    }
}
