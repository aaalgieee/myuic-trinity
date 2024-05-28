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
