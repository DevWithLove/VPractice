//
//  ExpandableButtonPanel.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/01/22.
//

import SwiftUI

struct ExpandableButtonItem: Identifiable {
    let id = UUID()
    let label: Image
    var action: (()-> Void)? = nil
}

struct ExpandableButtonPanel: View {
    
    let primaryButton: ExpandableButtonItem
    let secondButtons: [ExpandableButtonItem]
    
    private let size: CGFloat = 65
    private var cornerRadius: CGFloat {
        get { size / 2 }
    }
    
    @State private var isExpanded = false
    
    var body: some View {
        VStack {
            if isExpanded {
                ForEach(secondButtons) { button in
                    Button {
                        button.action?()
                    } label: {
                        button.label
                    }
                    .frame(width: self.size,
                           height: self.size)
                }
            }
            Button {
                withAnimation {
                    self.isExpanded.toggle()
                }
                primaryButton.action?()
            } label: {
                primaryButton.label
            }
            .frame(width: self.size, height: self.size)
        }
        .background(Color.white)
        .cornerRadius(cornerRadius)
        .shadow(radius: 5)
    }
}

struct ExpandableButtonPanel_Previews: PreviewProvider {
    static var previews: some View {
        let primaryButton = ExpandableButtonItem(label: Image(systemName: "plus"))
        let secondaryButtons = [ExpandableButtonItem(label: Image(systemName: "photo")), ExpandableButtonItem(label: Image(systemName: "camera"))]
        
        ExpandableButtonPanel(primaryButton: primaryButton, secondButtons: secondaryButtons )
    }
}
