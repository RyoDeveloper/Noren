//
//  CGSize+.swift
//  Noren
//
//  https://github.com/RyoDeveloper/Noren
//  Copyright © 2024 RyoDeveloper. All rights reserved.
//

import Foundation
import SwiftUI

extension CGSize {
    var primaryAxis: Axis {
        return width < height ? .vertical : .horizontal
    }
}
