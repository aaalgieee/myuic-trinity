import SwiftUI

struct checkView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var isAnimating = false
    @State private var isConnected = false
    @State private var isActive = false

    
    private var apiURL: URL? {
        guard let plistPath = Bundle.main.path(forResource: "APIKeys", ofType: "plist"),
              let plistDict = NSDictionary(contentsOfFile: plistPath),
              let urlString = plistDict["API_HEALTH"] as? String else {
            return nil
        }
        return URL(string: urlString)
    }

    var body: some View {
        NavigationView {
            ZStack {
                if colorScheme == .dark {
                    Color("sysColor")
                        .ignoresSafeArea()
                } else {
                    LinearGradient(gradient: Gradient(colors: [Color("pink-grad"), Color("sysColor")]), startPoint: .top, endPoint: .center)
                        .ignoresSafeArea()
                }
                VStack {
                    Spacer()
                    
                    Image("logo-loading")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200.0, height: 200.0)
                    
                    Spacer()
                    
                    Circle()
                        .trim(from: 0.0, to: 0.5)
                        .stroke(
                            AngularGradient(
                                gradient: Gradient(colors: [Color("pink-light").opacity(0.5), Color("pink-light").opacity(1.5)]),
                                center: .center
                            ),
                            style: StrokeStyle(lineWidth: 5, lineCap: .round)
                        )
                        .frame(width: 50, height: 50)
                        .rotationEffect(Angle(degrees: isAnimating ? 360 : 0))
                        .onAppear {
                            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                self.isAnimating = true
                            }
                            // Call the API on appear
                            self.callAPI()
                        }
                    
                    Spacer()
                    
                    if !isConnected {
                        Text("Connecting to UIC Servers...")
                            .font(.headline)
                            .padding(.bottom, -3.0)
                        
                        Text("Please be patient as they might be busy at the moment.")
                            .font(.caption)
                            .multilineTextAlignment(.center)
                    }
                    
                    Spacer()
                }
            }
            .overlay(
                NavigationLink(destination: loginView(), isActive: $isActive) {
                    EmptyView()
                }
                    .opacity(0)
            )
        }
    }

    func callAPI() {
        guard let url = apiURL else {
            print("Error: API URL not found")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                // Handle error
                print("Error calling API: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: [])
                if let dict = json as? [String: Any], let status = dict["status"] as? Int {
                    if status == 200 {
                        DispatchQueue.main.async {
                            self.isConnected = true
                            self.isActive = true
                            print(isConnected)
                        }
                    } else {
                        // Handle non-200 status code
                        print("API returned unexpected status code: \(status)")
                    }
                } else {
                    // Handle invalid JSON response
                    print("Invalid JSON response from API")
                }
            } catch {
                // Handle JSON parsing error
                print("Error parsing JSON response: \(error.localizedDescription)")
            }
        }.resume()
    }
}

#if DEBUG
struct checkView_Previews: PreviewProvider {
    static var previews: some View {
        checkView()
    }
}
#endif
