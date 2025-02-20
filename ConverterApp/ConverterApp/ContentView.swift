//
//  ContentView.swift
//  ConverterApp
//
//  Created by Tavin Severino on 2/3/25.
//
import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Blue Header (Use Navigation Title Instead)
                VStack {
                        Text("Converter App")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .top)
                            .padding(.top, 60)
                            .padding(.bottom, 30)
                            .background(Color.blue)
                }
                .frame(maxWidth: .infinity, alignment: .top)
                
                // Gray Section with Buttons
                ZStack {
                    Rectangle()
                        .fill(Color.gray)
                        .frame(height: 40) // No need for fixed width
                    HStack(spacing: 40) {
                        NavigationLink(destination: LengthView()) {
                            Text("Length")
                        }
                        NavigationLink(destination: TempView()) {
                            Text("Temp")
                        }
                        NavigationLink(destination: WeightView()) {
                            Text("Weight")
                        }
                        Button(action: {}) { Text("Time") }
                    }
                }
                .accentColor(.white)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    ContentView()
}
