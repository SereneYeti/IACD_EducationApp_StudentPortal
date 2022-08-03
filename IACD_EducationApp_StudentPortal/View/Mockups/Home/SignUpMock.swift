    //
    //  SignUpMock.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/08/03.
    //

import SwiftUI

struct HomeViewMockUp: View {
    @Binding var verified:Bool
    @State var profileClick : Bool = false
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var taskModel:TaskViewModel
    
    @State private var showWelcomeScreen: Bool = false
    @State private var showCalendarView: Bool = false
    @State private var showMap: Bool = false
    @State private var showNewsletterView: Bool = false
    
    var body: some View {
        ScrollView {
                //MARK: Top Bar + Today
            VStack {
                HStack {
                    VStack(alignment:.leading) {
                        Text("Good Morning")
                        Text("Student")
                            .font(.system(size: 35))
                            .bold()
                    }
                    Spacer()
                    Image(systemName:profileClick ? "x.circle.fill":"person.fill")
                        .font(.system(size: 25, weight: .light))
                        .background(
                            BlurBG(style: .systemUltraThinMaterialDark)
                                .frame(width: 45, height: 45)
                                .clipShape(Circle())
                        )
                        .onTapGesture {
                            profileClick.toggle()
                        }
                    
                }
                .padding(20)
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
                Text("News")
                    .hLeading()
                    .padding()
                    .padding(.leading)
                    .font(.system(size: 25,weight: .bold))
                    .foregroundColor(.white)
                
                TabView{
                    ForEach(newsItems){ newItems in
                        NewsCardView(newsTemp: newItems)
                            .padding()
                    }
                }.tabViewStyle(.page(indexDisplayMode: .always))
                    .frame(width:350, height: 380)
                
                    //MARK: where the events will go
                Text("Events")
                    .hLeading()
                    .padding()
                    .padding(.leading)
                    .font(.system(size: 25,weight: .bold))
                    .foregroundColor(.white)
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
                Text("Apps")
                    .hLeading()
                    .padding()
                    .padding(.leading)
                    .font(.system(size: 25,weight: .bold))
                    .foregroundColor(.white)
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 20) {
                        homeAppIconsView(homeIcons: homeIcons[0])
                        homeAppIconsView(homeIcons: homeIcons[1])
                    }
                }
                
                
                .padding()
            }
            
        }
        .onAppear{
            
            showWelcomeScreen = viewModel.firstTimeSignIn
        }
        .overlay(
            Verificationview()
                .offset(y: profileClick ? 0: 1000)
                .animation(.spring(response: 0.25, dampingFraction: 0.3, blendDuration: 0), value: profileClick)
        )
        .background(
            Image("bg3")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .overlay(
                    LinearGradient(gradient: Gradient(colors: [Color.clear, Color.black]), startPoint: .top, endPoint: .bottom)
                        .offset(y:100)
                )
                .hueRotation(Angle(degrees: 20))
        )
        .ignoresSafeArea(.all)
    }
}

struct HomeViewMockUp_Previews: PreviewProvider {
    static var previews: some View {
        HomeViewMockUp(verified: .constant(true))
            .environmentObject(AppViewModel())
            .environmentObject(TaskViewModel())
    }
}
    //MARK: Scrolling Icons
struct homeAppIcons: Identifiable{
    var id = UUID()
    var icon : String
    var color : String
    var text : String
    
}

struct homeAppIconsView: View{
    var homeIcons : homeAppIcons
    var body: some View{
        VStack{
            Image(systemName: homeIcons.icon)
                .font(.system(size: 35))
                .padding()
                .foregroundColor(Color(hex: homeIcons.color))
                .background(
                    RoundedRectangle(cornerRadius: 20, style: .continuous)
                        .foregroundColor(.white)
                )
            Text(homeIcons.text)
                .bold()
                .padding(.top,20)
                .foregroundColor(.white)
        }
        .frame(width: 165, height: 180)
        .background(
            Color(hex: homeIcons.color)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
    }
}

var homeIcons = [
    homeAppIcons(icon: "map", color: "a8dadc", text: "Campus Map"),
    homeAppIcons(icon: "calendar", color: "cbdfbd", text: "Calendar")
]
    //MARK: News Related Items
struct NewsCardView: View {
    var newsTemp : News
    var body: some View {
        VStack{
            Image(newsTemp.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                //                .frame(width: 330, height: 200)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .padding()
            
            Text(newsTemp.newsHeading)
                .font(.system(size: 16,weight: .bold))
                .hLeading()
                .padding(.leading)
            
            Spacer()
            
            Text(newsTemp.newsBody)
                .font(.caption)
                .padding([.leading,.trailing])
                .padding(.top,5)
            Text("Read More ...")
                .hLeading()
                .padding()
                .font(.footnote)
            
                //MARK: Expand the view
            Spacer()
            
        }
        .frame(width:350, height: 380)
        .background(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .foregroundColor(Color(hex: "f8f9fa"))
        )
        .padding()
    }
}

struct News: Identifiable{
    var id = UUID()
    var image: String
    var newsHeading: String
    var newsBody: String
}


var newsItems = [
    News(image: "News",
         newsHeading: "Stay up to date",
         newsBody: "This is the latest news and infromation regarding Vega University. Find out when the Important dates are."
        ),
    News(image: "news2",
         newsHeading: "Vega News",
         newsBody: "There is guest lecture in the auditoruim and attendance will count to ICE")
    
]


