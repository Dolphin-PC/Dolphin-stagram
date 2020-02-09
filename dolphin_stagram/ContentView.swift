//
//  ContentView.swift
//  dolphin_stagram
//
//  Created by 박찬영 on 2020/02/09.
//  Copyright © 2020 박찬영. All rights reserved.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI


struct ContentView: View {
    var body: some View {
        TabView{
            NavigationView{
                Home()
                    .navigationBarTitle("Dolphin-stagram")
                    .navigationBarItems(leading: Button(action:{
                        
                    }, label:{
                        Image("cam").resizable().frame(width:30,height: 30)
                        }).foregroundColor(Color("darkAndWhite"))
                        , trailing:
                        HStack{
                            Button(action:{
                                
                            }){
                                Image("IGTV").resizable().frame(width:30, height:30)
                            }.foregroundColor(Color("darkAndWhite"))
                            Button(action:{
                                
                            }){
                                Image("send").resizable().frame(width:30, height:30)
                            }.foregroundColor(Color("darkAndWhite"))
                        }
                )
            }.tabItem{
                Image("home")
            }
            Text("Find").tabItem({
                Image("find")
            })
            Text("Upload").tabItem({
                Image("plus")
            })
            Text("Likes").tabItem({
                Image("heart")
            })
            Text("Profile").tabItem({
                Image("people")
            })

        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home : View{
    
    @ObservedObject var observed = observer()
    @ObservedObject var postobserved = Postobserver()
    
    @State var show = false
    @State var user = ""
    @State var url = ""
    
    var body : some View{
        ScrollView(.vertical,showsIndicators: false){
            VStack{
                ScrollView(.horizontal,showsIndicators: false){
                    HStack{
                        ForEach(observed.status){i in
                            StatusCard(imgName: i.image, user: i.name, show: self.$show, user1: self.$user, url: self.$url)
                        }
                    }
                }
                
                if postobserved.posts.isEmpty{
                    Text("No Posts").fontWeight(.heavy)
                }else{
                    ForEach(postobserved.posts){i in
                        postCard(user: i.name, image: i.image, id: i.id, likes: i.likes, comments: i.comment)
                    }
                }
                
            }.sheet(isPresented: $show){
                statusView(url : self.url,name : self.user)
            }
        }
    }
}

struct StatusCard : View{
    var imgName = ""
    var user = ""
    @Binding var show : Bool
    @Binding var user1 : String
    @Binding var url : String
    
    var body : some View{
        VStack{
            AnimatedImage(url : URL(string: imgName))
                .resizable()
                .frame(width:80,height: 80)
                .clipShape(Circle())
                .onTapGesture {
                    self.user1 = self.user
                    self.url = self.imgName
                    self.show.toggle()
            }
            
            Text(user).fontWeight(.light)
        }
        
    }
}

struct postCard : View {
    var user = ""
    var image = ""
    var id = ""
    var likes = ""
    var comments = ""
    
    var body : some View{
        VStack(alignment: .leading, content: {
            
            HStack{
                AnimatedImage(url : URL(string: image)).resizable().frame(width: 30, height: 30)
                Text(user)
                Spacer()
                Button(action : {
                    
                }){
                    Image("menu").resizable().frame(width: 15, height: 15)
                }.foregroundColor(Color("darkAndWhite"))
            }
            
            AnimatedImage(url : URL(string : image))
            .resizable()
                .frame(height:350)
            
            HStack{
                Button(action : {
                    
                }){
                    Image("comment").resizable().frame(width: 30, height: 30)
                }.foregroundColor(Color("darkAndWhite"))
                
                Spacer()
                
                Button(action : {
                    
                }){
                    Image("heart").resizable().frame(width: 26, height: 26)
                }.foregroundColor(Color("darkAndWhite"))
                
                Spacer()
                
                Button(action : {
                    
                }){
                    Image("saved").resizable().frame(width: 35, height: 35)
                }.foregroundColor(Color("darkAndWhite"))
            }.padding(.top,8)
            
            Text("\(likes) Likes")
            Text("View all \(comments) Comments")
        }).padding(8)
    }
}

class observer : ObservableObject{
    @Published var status = [datatype]()
    
    init() {
        let db = Firestore.firestore()
        db.collection("status").addSnapshotListener{ (snap,err) in
            if err != nil{
                print((err?.localizedDescription))
                return
            }
            
            for i in snap!.documentChanges {
                if i.type == .added{
                    let id = i.document.documentID
                    let name = i.document.get("name") as! String
                    let image = i.document.get("image") as! String
                    
                    self.status.append(datatype(id: id, name: name, image: image))
                }
                
                if i.type == .removed{
                    let id = i.document.documentID
                    
                    for j in 0..<self.status.count{
                        if self.status[j].id == id{
                            self.status.remove(at: j)
                            return
                        }
                    }
                }
            }
        }
    }
}

class Postobserver : ObservableObject{
    @Published var posts = [datatype1]()
    
    init() {
        let db = Firestore.firestore()
        db.collection("posts").addSnapshotListener{ (snap,err) in
            if err != nil{
                print((err?.localizedDescription))
                return
            }
            
            for i in snap!.documentChanges {
                if i.type == .added{
                    let id = i.document.documentID
                    let name = i.document.get("name") as! String
                    let image = i.document.get("image") as! String
                    let comment = i.document.get("comment") as! String
                    let likes = i.document.get("likes") as! String
                    
                    
                    self.posts.append(datatype1(id: id, name: name, image: image, comment: comment, likes: likes))
                }
                
                
                if i.type == .removed{
                    let id = i.document.documentID
                    
                    for j in 0..<self.posts.count{
                        if self.posts[j].id == id{
                            self.posts.remove(at: j)
                            return
                        }
                    }
                }
            }
        }
    }
}


struct datatype1 : Identifiable {
    var id : String
    var name : String
    var image : String
    var comment : String
    var likes : String
    
}

struct datatype : Identifiable {
    var id : String
    var name : String
    var image : String
    
}

struct statusView : View{
    var url = ""
    var name = ""
    
    var body : some View{
        
        ZStack{
            AnimatedImage(url : URL(string: url)).resizable()
            
            VStack{
                HStack{
                    Text(name)
                        .font(.headline).fontWeight(.heavy).padding()
                    Spacer()
                    
                }
                Spacer()
            }
        }
        
    }
}
