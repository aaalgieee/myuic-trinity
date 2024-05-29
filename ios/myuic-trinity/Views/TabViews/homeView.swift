//
//  homeView.swift
//  myuic-trinity
//
//  Created by Al Gabriel on 5/28/24.
//

import SwiftUI

struct homeView: View {
    @Environment(\.colorScheme) var colorScheme
    let date = Date()
    
    var gradientColors: [Color] {
        let currentHour = Calendar.current.component(.hour, from: Date())
        
        switch currentHour {
        case 0..<12:
            return [Color("morning-amber"), Color("sysColor")]
        case 12..<17:
            return [Color("afternoon-amber"), Color("sysColor")]
        case 17..<24:
            return [Color("evening-sky"), Color("sysColor")]
        default:
            return [Color("sysColor"), Color("sysColor")]
        }
    }
    
    
    var imageTime: Image {
        let currentHour = Calendar.current.component(.hour, from: Date())
        switch currentHour {
        case 0..<12:
            return Image(systemName: "sun.min")
            
        case 12..<17:
            return Image(systemName: "sun.max")
        case 17..<24:
            return Image(systemName: "moon")
            
        default:
            return Image(systemName: "sun.min")
        }
    }
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color("sysColor"))
                .ignoresSafeArea()
            
            LinearGradient(gradient: Gradient(colors: gradientColors), startPoint: .top, endPoint: .center)
                .ignoresSafeArea()
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading){
                    imageTime
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100)
                        .foregroundStyle(colorForCurrentTime())
                    
                    
                    Text(greetingForCurrentTime())
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Juan!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Text("Today is ")
                        .font(.title2)
                        .fontWeight(.light)
                    + Text(formattedDate())
                        .font(.title2)
                        .fontWeight(.light)
                    
                    
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack(spacing: 30) {
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                VStack {
                                    Image(systemName: "dollarsign.square")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(Color("pink-light"))
                                    Text("Finance")
                                        .foregroundColor(.primary)
                                }
                            })
                            
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                VStack {
                                    Image(systemName: "newspaper")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(Color("pink-light"))
                                    Text("Clearance")
                                        .foregroundColor(.primary)
                                }
                            })
                            
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                VStack {
                                    Image(systemName: "book")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(Color("pink-light"))
                                    Text("Handbook")
                                        .foregroundColor(.primary)
                                }
                            })
                            
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                VStack {
                                    Image(systemName: "envelope.open")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(Color("pink-light"))
                                    Text("E-mail")
                                        .foregroundColor(.primary)
                                }
                            })
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                VStack {
                                    Image("classroom")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .foregroundColor(Color("pink-light"))
                                        .frame(width: 50, height: 50)
                                    Text("Classroom")
                                        .foregroundColor(.primary)
                                }
                            })
                            
                            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                                VStack {
                                    Image(systemName: "bookmark")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 50, height: 50)
                                        .foregroundStyle(Color("pink-light"))
                                    Text("Resources")
                                        .foregroundColor(.primary)
                                }
                            })
                            
                        }
                    }
                    .padding(.top, 50)
                }
                .padding()
            }
        }
        
    }
    
    // functions
    func formattedDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, YYYY"
        return dateFormatter.string(from: date)
    }
    
    func colorForCurrentTime() -> Color {
        let currentHour = Calendar.current.component(.hour, from: Date())
        switch currentHour {
        case 0..<12:
            return Color.yellow
        case 12..<17:
            return Color.orange
        case 17..<24:
            return Color.cyan
        default:
            return Color.yellow
        }
    }
    
    // Helper function to determine the greeting based on the current time
    func greetingForCurrentTime() -> String {
        let currentHour = Calendar.current.component(.hour, from: Date())
        switch currentHour {
        case 0..<12:
            return "Good Morning,"
        case 12..<17:
            return "Good Afternoon,"
        case 17..<24:
            return "Good Evening,"
        default:
            return "Hello,"
        }
    }
}

#Preview {
    homeView()
}
