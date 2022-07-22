//
//  DirectUserToSettingsView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 20/07/22.
//

import SwiftUI

struct DirectUserToSettingsView: View {
    var body: some View {
        Button {
            openSystemSettings()
        } label: {
            Text("Turn on dark mode")
        }
    }

    func openAppSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }

    func openSystemSettings() {
        guard let settingsUrl = URL(string: "App-prefs:DISPLAY") else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: nil)
        }
    }
}

struct DirectUserToSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        DirectUserToSettingsView()
    }
}
