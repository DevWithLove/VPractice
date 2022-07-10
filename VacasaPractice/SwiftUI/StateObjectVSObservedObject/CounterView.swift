//
//  CounterView.swift
//  VacasaPractice
//
//  Created by Tony Mu on 28/06/22.
//

/*
 105

 @ObservedObject

 When a view creates its own @ObservedObject instance it is recreated every time a view is discarded and redrawn:

 struct ContentView: View {
   @ObservedObject var viewModel = ViewModel()
 }
 On the contrary a @State variable will keep its value when a view is redrawn.

 @StateObject

 A @StateObject is a combination of @ObservedObject and @State - the instance of the ViewModel will be kept and reused even after a view is discarded and redrawn:

 struct ContentView: View {
   @StateObject var viewModel = ViewModel()
 }
 Performance

 Although an @ObservedObject can impact the performance if the View is forced to recreate a heavy-weight object often, it should not matter much when the @ObservedObject is not complex.

 refer to https://www.avanderlee.com/swiftui/stateobject-observedobject-differences/
 */
import SwiftUI

final class CounterViewModel: ObservableObject {
    @Published var count = 0

    init() {
        print("Inital called")
    }

    func incrementCounter() {
        count += 1
    }
}

struct CounterView: View {
//    @ObservedObject var viewModel = CounterViewModel()
    @StateObject var viewModel = CounterViewModel()

    var body: some View {
        VStack {
            Text("Count is: \(viewModel.count)")
            Button("Increment Counter") {
                viewModel.incrementCounter()
            }
        }
    }
}

struct RandomNumberView: View {
    @State var randomNumber = 0

    var body: some View {
        VStack {
            Text("Random number is: \(randomNumber)")
            Button("Randomize number") {
                randomNumber = (0..<1000).randomElement()!
            }
        }.padding(.bottom)

        CounterView()
    }
}

struct RandomNumberView_Previews: PreviewProvider {
    static var previews: some View {
        RandomNumberView()
    }
}
