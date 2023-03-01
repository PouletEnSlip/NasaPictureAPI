//
//  PhotoInfo.swift
//  NasaPhoto
//
//
//

import Foundation

struct PhotoInfo: Decodable {
    var title: String
    var explanation: String
    var url: URL
    var copyright: String?
}
