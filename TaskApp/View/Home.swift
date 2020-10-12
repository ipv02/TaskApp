//
//  Home.swift
//  TaskApp
//
//  Created by Igor P-V on 08.10.2020.
//

import SwiftUI
import CoreData

struct Home: View {
    
    @StateObject var homeData = HomeViewModel()
    
    // Fetching Data
    @FetchRequest(entity: Task.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "date", ascending: true)],
                  animation: .spring()) var results : FetchedResults<Task>
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .bottom), content: {
            
            VStack(spacing: 0) {
                
                HStack {
                    Text("Tasks")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.black)
                    
                    Spacer(minLength: 0)
                }
                .padding()
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                if results.isEmpty {
                    
                    Spacer()
                    
                    Text("No Tasks!!!")
                        .font(.title)
                        .foregroundColor(.black)
                        .fontWeight(.heavy)
                    
                    Spacer()
                } else {
                    
                    ScrollView(.vertical, showsIndicators: false, content: {
                        
                        LazyVStack(alignment: .leading, spacing: 20) {
                            
                            ForEach(results) { task in
                                
                                VStack(alignment: .leading, spacing: 5, content: {
                                    Text(task.content ?? "")
                                        .font(.title)
                                        .fontWeight(.bold)
                                    
                                    Text(task.date ?? Date(), style: .date)
                                        .fontWeight(.bold)
                                    
                                })
                                .foregroundColor(.black)
                                .contextMenu {
                                    Button(action: { homeData.editItem(item: task) }, label: {
                                        Text("Edit")
                                    })
                                    
                                    Button(action: {
                                        context.delete(task)
                                        try! context.save()
                                    }, label: {
                                        Text("Delete")
                                    })
                                }
                            }
                        }
                        .padding()
                    })
                }
            }
            
            //Add Button
            Button(action: { homeData.isNewData.toggle() }, label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .padding(20)
                    .background(
                        AngularGradient(gradient: .init(colors: [Color(#colorLiteral(red: 0.737254902, green: 0.5607843137, blue: 0.5607843137, alpha: 1)), Color(#colorLiteral(red: 0.9568627451, green: 0.6431372549, blue: 0.3764705882, alpha: 1))]), center: .center)
                    )
                    .clipShape(Circle())
                
            })
            .padding()
            
        })
        .ignoresSafeArea(.all, edges: .top)
        .background(Color.black.opacity(0.06).ignoresSafeArea(.all, edges: .all))
        .sheet(isPresented: $homeData.isNewData, content: {
            NewDataView(homeData: homeData)
        })
    }
}




//ScrollView(.vertical, showsIndicators: false, content: {
//
//    LazyVStack(alignment: .leading, spacing: 20) {
//
//        ForEach(results) { task in
//
//            VStack(alignment: .leading, spacing: 5, content: {
//                Text(task.content ?? "")
//                    .font(.title)
//                    .fontWeight(.bold)
//
//                Text(task.date ?? Date(), style: .date)
//                    .fontWeight(.bold)
//
//            })
//            .foregroundColor(.black)
//            .contextMenu {
//                Button(action: { homeData.editItem(item: task) }, label: {
//                    Text("Edit")
//                })
//
//                Button(action: {
//                    context.delete(task)
//                    try! context.save()
//                }, label: {
//                    Text("Delete")
//                })
//            }
//        }
//    }
//    .padding()
//})
