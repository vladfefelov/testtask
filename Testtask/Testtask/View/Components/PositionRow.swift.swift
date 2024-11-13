//
//  PositionRow.swift.swift
//  Testtask
//
//  Created by Vladislav Fefelov on 13.11.2024.
//

import SwiftUI

struct PositionRow: View {
    let position: Position
    @Binding var selectedPositionId: Int

    var body: some View {
        HStack {
            Image(systemName: selectedPositionId == position.id ? "smallcircle.fill.circle.fill" : "circle")
                .foregroundColor(selectedPositionId == position.id ? Colors.secondary : Color.gray)
            
            Text(position.name)
                .foregroundColor(.black)
                .padding(.leading, 8)
                .font(TextStyles.body1)
        }
        .padding(.vertical, 4)
        .onTapGesture {
            selectedPositionId = position.id
        }
    }
}
