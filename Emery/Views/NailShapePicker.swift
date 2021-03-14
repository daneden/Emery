//
//  NailShapePicker.swift
//  Emery
//
//  Created by Daniel Eden on 14/03/2021.
//

import SwiftUI

fileprivate var SWATCH_SPACING: CGFloat = 4

struct NailShapePicker: View {
  @Binding var selection: NailShape
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Nail Shape")
        .font(.caption)
        .foregroundColor(.secondary)
        .padding(.horizontal)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(
          alignment: .center,
          spacing: SWATCH_SPACING
        ) {
          ForEach(NailShape.allCases, id: \.self) { shape in
            NailshapeButton(shape: shape, isSelected: selection == shape)
              .onTapGesture {
                withAnimation(TIGHT_SPRING) { self.selection = shape }
              }
          }
        }.padding(.horizontal).padding(.bottom).padding(.top, SWATCH_SPACING)
      }
    }
  }
}

struct NailshapeButton: View {
  var shape: NailShape
  var isSelected: Bool
  
  var body: some View {
    HStack(spacing: 8) {
      Image("Shape=\(shape.rawValue)")
        .resizable()
        .aspectRatio(contentMode: .fit)
        .frame(width: 10, height: 30)
        .rotationEffect(.degrees(25))
        .foregroundColor(isSelected ? .white : .secondary)
      Text(shape.description)
    }.padding(.horizontal, 12).padding(.vertical, 4)
    .background(isSelected ? Color.accentColor : Color.secondary.opacity(0.2))
    .foregroundColor(isSelected ? Color.white : Color.primary)
    .cornerRadius(6)
  
  }
}

struct NailShapePicker_Previews: PreviewProvider {
    static var previews: some View {
      NailShapePicker(selection: .constant(.almond))
    }
}
