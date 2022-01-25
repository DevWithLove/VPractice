//
//  CircleImage.swift.swift
//  Landmarks
//
//  Created by Tony Mu on 17/01/22.
//

import SwiftUI

struct CircleImage: View {
    var image: Image
    
    var body: some View {
        image
            .clipShape(Circle())
            .overlay(content: {
                Circle().stroke(.gray, lineWidth: 4)
            })
            .shadow(radius: 7)
    }
}

struct CircleImage_Previews: PreviewProvider {
    static var previews: some View {
        CircleImage(image: Image("turtlerock"))
    }
}

