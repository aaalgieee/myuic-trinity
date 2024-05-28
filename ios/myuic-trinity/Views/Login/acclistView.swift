//
//  acclistView.swift
//  myuic-trinity
//
//  Created by Al Gabriel on 5/28/24.
//

import SwiftUI

struct acclistView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var student_id: String = ""
    @State private var student_password: String = ""
    var body: some View {
        ZStack{
            Rectangle()
                   .foregroundColor(Color("sysColor"))
                   .ignoresSafeArea()

               if colorScheme == .dark {
                   Rectangle()
                       .foregroundColor(Color("sysColor"))
                       .ignoresSafeArea()
               } else {
                   LinearGradient(gradient: Gradient(colors: [Color("pink-grad"), Color("sysColor")]), startPoint: .top, endPoint: .center)
                       .ignoresSafeArea()
               }
            
            VStack{
                
                Image("myuic-logo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100)
                    .padding(.vertical, 20.0)
                
                Text("MyUIC ")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                + Text("Trinity")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                VStack(alignment: .leading){
                    Text("Login with existing account")
                        .font(.title2)
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                    
                    Text("Student ID")
                        .padding(.top, 15)
                    TextField("e.g. 20000000XXX", text: $student_id)
                        .keyboardType(.numberPad)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                                .background(Color(.systemGray6))
                        )
                    Text("Password")
                        .padding(.top, 15)
                    SecureField("Enter your password", text: $student_password)
                        .padding(12)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                                .background(Color(.systemGray6))
                        )
                }
                Spacer()
                
                VStack{
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        Text("Login")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color("pink-grad-top"), Color("pink-grad-bot")]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                            )
                            .cornerRadius(8)
                    })
                }
                Spacer()
                Spacer()
                HStack(alignment: .center){
                    Text("Ported with ❤️ by:")
                    Link("Gab", destination: URL(string: "https://x.com/aaalgieee")!)
                        .foregroundStyle(Color("pink-light"))
                    Text("and")
                    Link("Ned", destination: URL(string: "https://x.com/npned")!)
                        .foregroundStyle(Color("pink-light"))
                    
                }
            }
            .padding()
            
            
        }
        
    }
}

#Preview {
    acclistView()
}
