//
//  SkintonePicker.swift
//  Emery
//
//  Created by Daniel Eden on 06/03/2021.
//

import SwiftUI

let DEFAULT_COLOR = UIColor.systemGray4.cgColor
fileprivate let SWATCH_SIZE: CGFloat = 40.0
fileprivate let SWATCH_SPACING: CGFloat = 4

struct SkintonePicker: View {
  @Binding var selection: CGColor
  
  var body: some View {
    VStack(alignment: .leading) {
      Text("Skin Tone")
        .font(.caption)
        .foregroundColor(.secondary)
        .padding(.horizontal)
      ScrollView(.horizontal, showsIndicators: false) {
        HStack(
          alignment: .center,
          spacing: SWATCH_SPACING
        ) {
          SkintoneSwatch(isSelected: selection == DEFAULT_COLOR)
            .onTapGesture {
              self.selection = DEFAULT_COLOR
            }
          
          ForEach(Array(skintones), id: \.self) { swatch in
            SkintoneSwatch(color: swatch, isSelected: selection == swatch)
              .onTapGesture {
                self.selection = swatch
              }
          }
        }.padding(.horizontal).padding(.bottom).padding(.top, SWATCH_SPACING)
      }
    }
  }
}

struct SkintoneSwatch: View {
  var color: CGColor = DEFAULT_COLOR
  var isSelected: Bool = false
  var body: some View {
    Color(color)
      .frame(width: SWATCH_SIZE, height: SWATCH_SIZE)
      .cornerRadius(SWATCH_SPACING * 0.75)
      .overlay(color == DEFAULT_COLOR
                ? AnyView(Image(systemName: "xmark").font(Font.body.bold()).foregroundColor(Color(UIColor.systemGray.cgColor)))
                : AnyView(EmptyView())
      )
      .overlay(
        isSelected
          ? AnyView(RoundedRectangle(cornerRadius: 4).stroke(Color.accentColor, lineWidth: 4))
          : AnyView(EmptyView())
      )
  }
}
