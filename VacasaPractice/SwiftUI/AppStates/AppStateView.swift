//
//  AppStateView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 6/02/22.
//
/*
 
 Terminated by the end user, you can do something in -[UIApplication applicationWillEnterBackground:], in which case, -[UIApplication applicationWillTerminate:] will NOT be called.

 Dropped by the system, such as memory not enough, you can do something in -[UIApplication applicationWillTerminate:], in which case, we do NOT know whether applicationWillEnterBackground: has been called;

 Crashed, nothing can be done except using some kind of Crash Reporting Tool. (Edited: catching SIGKILL is impossible)
 
 */


import SwiftUI

struct AppStateView: View {
    @State private var state = "State"
    //Use inside scene root view (usually ContentView) for scenePhase, it will not work in noe root views
    @Environment(\.scenePhase) private var scenePhase
    var body: some View {
        Text(state)
            .padding()
            .onChange(of: scenePhase) { newValue in
                switch newValue {
                case .background:
                    print("app in background")
                case .inactive:
                    print("app inactive")
                case .active:
                    print("app actives")
                @unknown default:
                    print("unknown state")
                }
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                print("app inactive")
                self.state = "inactive"
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
                print("app active")
                self.state = "active"
            }
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didEnterBackgroundNotification)) { _ in
                print("app background")
            }
    }
}

struct AppStateView_Previews: PreviewProvider {
    static var previews: some View {
        AppStateView()
    }
}
