//
//  CounterView.swift
//  Pinch
//
//  Created by Jadoul Nicolas on 22/04/2023.
//

import SwiftUI

struct CounterView: View {
    @State var counter: String = "hello"
    var body: some View {
        Button() {
            counter = counter + " world"
        } label: {
            Text(counter)
//            Text($counter)
        }
    }
}

struct ContentView2: View {
    @State var greeting: Int = 0
    var body: some View {
        SwiftUIViewA(greeting: greeting)
            .onTapGesture {
                greeting += 1
            }
    }
}

struct SwiftUIViewA: View {
    var greeting:Int
    var body: some View {
        Text("\(greeting)")
    }
}

struct CounterView_Previews: PreviewProvider {
    static var previews: some View {
        CounterView()
    }
}
