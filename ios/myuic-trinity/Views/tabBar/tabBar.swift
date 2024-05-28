//
//  navbar.swift
//  myuic-trinity
//
//  Created by Al Gabriel on 5/24/24.
//

import SwiftUI

struct tabBar: View {
    @State private var selectedTab = 0
    var body: some View {
        TabView(selection: $selectedTab) {
            homeView()
                .tabItem {
                    VStack{
                        Image(systemName: "house")
                            .environment(\.symbolVariants,selectedTab == 0 ? .fill: .none)
                        Text("Home")
                    }
                }
                .onAppear {selectedTab = 0}
                .tag(0)
            
            Text("Schedule")
                .tabItem {
                    VStack {
                        Image(systemName: "calendar")
                            .environment(\.symbolVariants,selectedTab == 1 ? .fill: .none)
                        Text("Schedule")
                    }
                }
                .onAppear {selectedTab = 1}
                .tag(1)
            
            Text("Reports")
                .tabItem {
                    VStack {
                        Image(systemName: "chart.bar")
                            .environment(\.symbolVariants,selectedTab == 2 ? .fill: .none)
                        Text("Reports")
                    }
                }
                .onAppear {selectedTab = 2}
                .tag(2)
            
            Text("Finance")
                .tabItem {
                    VStack {
                        Image(systemName: "dollarsign.square")
                            .environment(\.symbolVariants,selectedTab == 3 ? .fill: .none)
                        Text("Finance")
                    }
                }
                .onAppear {selectedTab = 3}
                .tag(3)
            
            Text("Menu")
                .tabItem {
                    VStack {
                        Image(systemName: "line.3.horizontal")
                            .environment(\.symbolVariants,selectedTab == 4 ? .fill: .none)
                        Text("Menu")
                    }
                }
            
                .onAppear {selectedTab = 4}
                .tag(4)
        }
        .tint(.pink)
    }
        
}

#Preview {
    tabBar()
}
