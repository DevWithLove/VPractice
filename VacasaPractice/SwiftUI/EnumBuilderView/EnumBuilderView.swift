//
//  EnumBuilderView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 18/03/22.
//

import SwiftUI

struct EnumBuilderView: View {
    let key = "HoldBookButton"
    let value = "%@ - %@ %@"
    let enumBuilder = StringEnumBuilder(template: StringEnumBuilder.defaultTemlate, moduleName: "VCBooking", accessLevel: .public)
    var body: some View {
        let result = enumBuilder.addNewLine()
                                .addTab(2)
                                .addComment("Hode a Booking")
                                .addNewLine()
                                .addTab(2)
                                .addElement(value, for: key)
                                .build()
        Text(result)
    }
}

struct EnumBuilderView_Previews: PreviewProvider {
    static var previews: some View {
        EnumBuilderView()
.previewInterfaceOrientation(.landscapeLeft)
    }
}
