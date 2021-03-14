//
//  ButtonStyle.swift
//  Emery
//
//  Created by Daniel Eden on 14/03/2021.
//

import Foundation
import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .foregroundColor(configuration.isPressed ? Color.white.opacity(0.7) : .white)
      .padding()
      .background(Color.accentColor)
      .cornerRadius(12)
  }
}

struct SecondaryButtonStyle: ButtonStyle {
  func makeBody(configuration: Configuration) -> some View {
    configuration
      .label
      .foregroundColor(configuration.isPressed ? Color.primary.opacity(0.7) : .primary)
      .padding()
      .background(Color.secondary.opacity(0.2))
      .cornerRadius(12)
  }
}
