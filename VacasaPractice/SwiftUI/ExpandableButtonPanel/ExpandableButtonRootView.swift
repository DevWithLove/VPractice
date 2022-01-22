//
//  ExpandableButtonRootView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 23/01/22.
//

import SwiftUI

struct ExpandableButtonRootView: View {
    
    @State private var showAlert = false
    
    var body: some View {
        ZStack {
            // Content View
            List(1...10 , id: \.self) { i in
                Text("Row \(i)")
            }
            
            // Set Exandable Button
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    ExpandableButtonPanel(primaryButton: ExpandableButtonItem(label: Image(systemName: "ellipsis")),
                                          secondButtons: [ExpandableButtonItem(label: Image(systemName: "photo")) {
                        showAlert.toggle()
                    }, ExpandableButtonItem(label: Image(systemName: "camera")){
                        showAlert.toggle()
                    }])
                        .padding()
                }
            }
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Tap!"))
            })
        }
        .navigationBarTitle("Expandable button")
    }
}

struct ExpandableButtonRootView_Previews: PreviewProvider {
    static var previews: some View {
        ExpandableButtonRootView()
    }
}
