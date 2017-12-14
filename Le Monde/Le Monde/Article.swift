//
//  Article.swift
//  Le Monde
//
//  Created by LETUE Erwann on 14/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import UIKit

class Article {
    var title: String?
    var chapo: String?
    var permalink: String?
    var imageAdress: String?
    var image: UIImage?
}

extension Article: CustomStringConvertible {
    var description: String {
        return "Article:\n--title = \(title ?? "")\n--chapo = \(chapo ?? "")\n--permalink = \(permalink ?? "")\n--imageAdress = \(imageAdress ?? "")"
    }
}
