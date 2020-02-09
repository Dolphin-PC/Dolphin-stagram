// ContetView.swift


  import SwiftUI
  import Firebase
  import SDWebImageSwiftUI
  
  
  struct ContentView: View {
      var body: some View {
          
          TabView{
              
              NavigationView{
                  
                  Home()
                      .navigationBarTitle("Dolphin-stagram")
                      .navigationBarItems(leading: Button(action: {
                          
                      }, label: {
                          
                          Image("cam").resizable().frame(width: 30, height: 30)
                          
                      })
                      .foregroundColor(Color("darkAndWhite"))
                      , trailing:
                  
                          HStack{
                              
                              Button(action: {
                                  
                              }) {
                                  
                                  Image("IGTV").resizable().frame(width: 30, height: 30)
                                  
                              }.foregroundColor(Color("darkAndWhite"))
                              
                              Button(action: {
                                  
                              }) {
                                  
                                  Image("send").resizable().frame(width: 30, height: 30)
                              }
                              .foregroundColor(Color("darkAndWhite"))
                          }
                  
                  )
                  
                  
              }.tabItem {
                  
                  Image("home")
              }
              
              Text("Find").tabItem {
                  
                  Image("find")
              }
              
              Text("Upload").tabItem {
                  
                  Image("plus")
              }
              
              Text("Likes").tabItem {
                  
                  Image("heart")
              }
              
              Text("Profile").tabItem {
                  
                  Image("people")
              }
          }
      }
  }




