//
//  ProfileSummary.swift
//  VacasaPractice
//
//  Created by Tony Mu on 27/01/22.
//

import SwiftUI

struct ProfileSummary: View {
    var profile: Profile

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 10) {
                Text(profile.username)
                    .bold()
                    .font(.title)

                Text("Notifications: \(profile.prefersNotifications ? "On": "Off" )")
                Text("Seasonal Photos: \(profile.seasonalPhoto.rawValue)")
                Text("Goal Date: ") + Text(profile.goalDate, style: .date)
            }
            
            Divider()
            
            VStack(alignment: .leading) {
                Text("Recent Hikes")
                    .font(.headline)
                HikeView(hike: Hike.mockHikes[0])
            }
        }
    }
}

struct ProfileSummary_Previews: PreviewProvider {
    static var previews: some View {
        ProfileSummary(profile:.default)
    }
}
