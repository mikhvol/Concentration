//
//  Theme.swift
//  Concentration
//
//  Created by worker on 17/04/2019.
//  Copyright © 2019 Mike Volkov. All rights reserved.
//

import Foundation
import UIKit

struct Theme {
    var images: [String]
    var colorOfFrontsideCard: UIColor
    var colorOfBacksideCard: UIColor
    var fontColor: UIColor
    
    init(images: [String], colorOfFrontsideCard: UIColor, colorOfBacksideCard: UIColor, fontColor: UIColor) {
        self.images = images
        self.colorOfFrontsideCard = colorOfFrontsideCard
        self.colorOfBacksideCard = colorOfBacksideCard
        self.fontColor = fontColor
    }
}
