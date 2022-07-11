//
//  PreferenceKeySampleView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 11/07/22.
//

import SwiftUI

struct PreferenceKeySampleView: View {
    @State private var text: String = "Hello world!"
    var body: some View {
        VStack {
            SecondaryScreen(text: text)
               // .customTitle("Title from child view")
        }
        .onPreferenceChange(CustomTitlePreferenceKey.self) { title in
            text = title
        }
    }
}


extension View {
    func customTitle(_ text: String) -> some View {
        preference(key: CustomTitlePreferenceKey.self, value: text)
    }
}

struct PreferenceKeySampleView_Previews: PreviewProvider {
    static var previews: some View {
        PreferenceKeySampleView()
    }
}
struct SecondaryScreen: View {
    let text: String
    @State private var newValue : String = ""

    var body: some View {
        Text(text)
            .onAppear(perform: getDataFromDatabase)
            .customTitle(newValue)
    }

    func getDataFromDatabase() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.newValue = "New value from database"
        }
    }
}


struct CustomTitlePreferenceKey: PreferenceKey {
    static var defaultValue: String = ""

    static func reduce(value: inout String, nextValue: () -> String) {
        value = nextValue()
    }
}
