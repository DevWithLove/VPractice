//
//  DestinationView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 5/02/22.
//

import SwiftUI

struct DestinationView: View {
    // Using environment dismiss, instead bind isPresented from previous view. To ensure, the dimiss works for both push and present
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            Text("Hello, Destination View!")
            Button {
                dismiss()
            } label: {
                Text("Dismiss")
            }
        }
    }
}

struct DestinationView_Previews: PreviewProvider {
    static var previews: some View {
        DestinationView()
    }
}
