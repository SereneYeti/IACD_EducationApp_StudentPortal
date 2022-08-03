    //
    //  SignUpMock.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/08/03.
    //

import SwiftUI

struct HomeViewMock: View {
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    VStack(alignment:.leading) {
                        Text("Good Morning")
                        Text("Student")
                            .font(.system(size: 35))
                            .bold()
                    }
                    Spacer()
                    Image(systemName: "person.fill")
                        .font(.system(size: 25, weight: .light))
                        .background(
                            BlurBG(style: .systemUltraThinMaterialDark)
                                .frame(width: 45, height: 45)
                                .clipShape(Circle())
                        )
                }
                
                .padding()
                .padding(.top,40)
                
                Spacer()
                    .frame(height: 200)
                VStack(alignment:.leading) {
                    Text("Today")
                        .bold()
                    Text(Date().formatted(.dateTime.day().month(.wide).year()))
                 
                }
                .foregroundColor(.white)
                .hLeading()
                .padding(15)
                .padding(.leading,10)
                
                    //MARK: News feed
                VStack{
                    Image("news2")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 330, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                        .padding()
                    
                    Text("Vega News")
                        .font(.system(size: 16,weight: .bold))
                        .hLeading()
                        .padding(.leading)
                        
                    Spacer()
                        
                    Text("There is guest lecture in the auditoruim and attendance will count to ICE")
                        .font(.caption)
                        .padding([.leading,.trailing])
                        .padding(.top,5)
                    Text("Read More ...")
                        .hLeading()
                        .padding()
                        .font(.footnote)
                    Spacer()
                    
                }
                .frame(width:350, height: 380)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(Color(hex: "f8f9fa"))
                    )
                .padding()
                
                    //MARK: where the events will go
                VStack {
                    HStack{
                        Image(systemName: "record.circle.fill")
                            .font(.system(size: 20))
                        Text("Brand Challenge")
                            .font(.system(size: 25))
                            .bold()
                    }.hLeading()
                        .padding(.bottom, 2)
                    Text("This will have students from all dregrees working together and using thier skills to elevate a given brand")
                        .font(.footnote)
                        .lineLimit(2)
                        .frame(width: 200)
                        .hLeading()
                    Button {
                        
                    } label: {
                        Text("Read More")
                            .font(.footnote)
                            .padding(.top,5)
                            .hLeading()
                        
                    }

                }
                .padding()
                .hLeading()
                .frame(width:350, height: 180)
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(Color(hex: "f8f9fa"))
                        .overlay(
                            Image(systemName: "books.vertical.fill")
                                .font(.system(size: 100))
                                .foregroundColor(Color(hex: "f8f9fa"))
                                .background(
                                    Color(hex: "d8f3dc")
                                        .clipShape(Circle())
                                        .frame(width: 200, height: 250)
                                )
                                .hTrailing()
                                .offset(x:30)
                        )
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                )
                
                    //MARK: Where the map will go and calendar
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(0 ..< 2) { item in
                            VStack{
                                Image(systemName: "map")
                                    .font(.system(size: 35))
                                    .padding()
                                    .foregroundColor(Color(hex: "a8dadc"))
                                    .background(
                                        RoundedRectangle(cornerRadius: 20, style: .continuous)
                                            .foregroundColor(.white)
                                    )
                                Text("Campus Map")
                                    .bold()
                                    .padding(.top,20)
                                    .foregroundColor(.white)
                            }
                            .frame(width: 165, height: 180)
                            .background(
                                Color(hex: "a8dadc")
                            )
                            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        }
                    }
                }
                
              
                .padding()
            }
    }
        .background(
            Image("bg1")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                        .offset(y:100)
                )
                .hueRotation(Angle(degrees: -170))
        )
        .ignoresSafeArea(.all)
    }
}

struct SignUpMock_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewMock()
    }
}
