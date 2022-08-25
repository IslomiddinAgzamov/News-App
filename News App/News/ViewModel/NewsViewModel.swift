//
//  NewsViewModel.swift
//  News App
//
//  Created by Islomiddin on 24/08/22.
//

import Foundation

class NewsViewModel {
    
    let title: String
    
    let subtitle: String
    
    let imageURL: URL?
    
    var imageData: Data? = nil
    
    init(title: String, subtitle: String, imageURL: URL?) {
        self.title = title
        self.subtitle = subtitle
        self.imageURL = imageURL
    }
    
}


