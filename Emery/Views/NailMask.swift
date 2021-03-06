//
//  NailMask.swift
//  Emery
//
//  Created by Daniel Eden on 06/03/2021.
//

import SwiftUI

enum NailShape: String, Equatable, CaseIterable {
    case almond, arrowhead, ballerina, lipstick, oval, rounded, short, square, stiletto
    case squaredOval = "squared-oval"
    case mountainPeak = "mountain-peak"
    
    var description: String {
        return self.rawValue
            .replacingOccurrences(of: "-", with: " ")
            .capitalized
    }
}

struct NailMask: View {
    var selectedShape: NailShape = .almond
    var image: UIImage?
    var scaleFactor: CGFloat = 1.0
    var offset = CGSize()
    
    var mask: some View {
        Image("Shape=\(selectedShape.rawValue)")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 80)
    }
    
    var body: some View {
        if let image = image {
            mask
                .overlay(
                    Image(uiImage: image)
                        .scaleEffect(scaleFactor)
                        .offset(offset)
                        .mask(mask)
                )
        } else {
            mask.foregroundColor(.accentColor)
        }
        
    }
}

struct NailMask_Previews: PreviewProvider {
    static var previews: some View {
        NailMask()
    }
}
