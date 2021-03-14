//
//  FingerView.swift
//  Emery
//
//  Created by Daniel Eden on 06/03/2021.
//

import SwiftUI

let TIGHT_SPRING = Animation.interpolatingSpring(stiffness: 700.0, damping: 25.0)

struct FingerView: View {
  @State var selectedShape: NailShape = .almond
  @State var imagePickerOpen = false
  @State private var chosenImage: UIImage?
  
  @State var scaleFactor: CGFloat = 0.5
  @State var lastScaleFactor: CGFloat = 0.5
  
  @State var offset: CGSize = .init()
  @State var lastOffset: CGSize = .init()
  
  @State var skintoneColor: CGColor = DEFAULT_COLOR
  
  @State var hidingControls = false
  
  var body: some View {
    VStack {
      Spacer()
      
      ZStack(alignment: .bottom) {
        Image("finger-shape")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 112)
          .mask(
            LinearGradient(
              gradient: .init(colors: [.black, .clear]),
              startPoint: .center,
              endPoint: .bottom
            )
          )
          .offset(y: 15)
          .foregroundColor(skintoneColor == DEFAULT_COLOR ? .clear : Color(skintoneColor))
        
        Image("finger-outline")
          .resizable()
          .aspectRatio(contentMode: .fit)
          .frame(width: 112)
          .mask(
            LinearGradient(
              gradient: .init(colors: [.black, .clear]),
              startPoint: .center,
              endPoint: .bottom
            )
          )
          .opacity(0.2)
        
        NailMask(
          selectedShape: selectedShape,
          image: chosenImage,
          scaleFactor: scaleFactor,
          offset: offset)
          .offset(y: -156)
      }.gesture(MagnificationGesture()
                  .onChanged {
                    self.scaleFactor = self.lastScaleFactor * $0.magnitude
                  }
                  .onEnded { _ in
                    self.lastScaleFactor = self.scaleFactor
                  }
      ).simultaneousGesture(DragGesture()
                              .onChanged { value in
                                self.offset.height = self.lastOffset.height + value.translation.height
                                self.offset.width = self.lastOffset.width + value.translation.width
                              }
                              .onEnded { _ in
                                self.lastOffset = self.offset
                              }
      ).onTapGesture {
        withAnimation(.interactiveSpring()) { hidingControls.toggle() }
      }
      
      Spacer()
      
      if !hidingControls {
        NailShapePicker(selection: $selectedShape)
        SkintonePicker(selection: $skintoneColor)
        
        HStack {
          Button(action: { imagePickerOpen.toggle() }) {
            Label("Choose Image", systemImage: "photo.on.rectangle.angled")
              .frame(maxWidth: .infinity, maxHeight: .infinity)
          }.buttonStyle(PrimaryButtonStyle())
          
          if chosenImage != nil {
            Button(action: { withAnimation(TIGHT_SPRING) { chosenImage = nil } }) {
              Label("Clear Image", systemImage: "xmark")
                .labelStyle(IconOnlyLabelStyle())
                .frame(maxHeight: .infinity)
            }.buttonStyle(SecondaryButtonStyle())
          }
        }
        .fixedSize(horizontal: false, vertical: true)
        .padding(.horizontal)
        .font(Font.body.bold())
      }
      
    }
    .edgesIgnoringSafeArea(hidingControls ? .all : .init())
    .statusBar(hidden: hidingControls)
    .sheet(isPresented: $imagePickerOpen) {
      ImagePicker(image: $chosenImage)
    }
  }
}

struct FingerView_Previews: PreviewProvider {
  static var previews: some View {
    FingerView()
  }
}
