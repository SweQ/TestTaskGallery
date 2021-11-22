//
//  SizesForTableRow.swift
//  TestGalleryApp
//
//  Created by alexKoro on 31.10.21.
//

import Foundation
import UIKit

class TableRowSizes {
    static let share = TableRowSizes()
    
    private init() { }
    
    var forZeroPhotos: CGSize?
    var forLessThanFourPhotos: CGSize?
    var forMoreThanThreePhotos: CGSize?
    
    func getSize(for count: Int) -> CGSize? {
        switch count {
        case 0:
            return forZeroPhotos
        case 1...3:
            return forLessThanFourPhotos
        case 4... :
            return forMoreThanThreePhotos
        default:
            return nil
        }
    }
    
}
