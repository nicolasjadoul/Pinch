//
//  PagesModel.swift
//  Pinch
//
//  Created by Jadoul Nicolas on 22/04/2023.
//

import Foundation

struct  Page: Identifiable {
    let id: Int
    let imageName: String
}

extension Page {
    var thumbnailName: String {
        return "thumb-" + imageName
    }
}
