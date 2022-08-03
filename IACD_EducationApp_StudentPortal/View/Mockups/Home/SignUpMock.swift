    //
    //  SignUpMock.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/08/03.
    //

import SwiftUI

struct HomeViewMockUp: View {
    @State var profileClick : Bool = false
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var taskModel:TaskViewModel
    @Binding var verified:Bool
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
                    
                    
                }
                .padding(20)
                .padding(.top,40)
                .onTapGesture {
                    print("tapped")
                    self.profileClick.toggle()
                }
                
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
                    NewsCardView(newsTemp: newsItems[0])
                        .onTapGesture {
                            showNewsletterView.toggle()
                            print("Showing News")
                        }
                        .padding()
                    NewsCardView(newsTemp: newsItems[1])
                        .padding()
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(width:350, height: 380)
                
                    //MARK:  Events
                Text("Events")
                    .hLeading()
                    .padding()
                    .padding(.leading)
                    .font(.system(size: 25,weight: .bold))
                    .foregroundColor(.white)
                TabView{
                    EventAppIconsCardView(eventIcon: eventIconList[0])
                    EventAppIconsCardView(eventIcon: eventIconList[1])
                }
                .tabViewStyle(.page(indexDisplayMode: .always))
                .frame(width:350, height: 180)
                
                    //MARK: Where the map will go and calendar
                Text("Apps")
                    .hLeading()
                    .padding()
                    .padding(.leading)
                    .font(.system(size: 25,weight: .bold))
                    .foregroundColor(.white)
                ScrollView(.horizontal,showsIndicators: false) {
                    HStack(spacing: 20) {
                        NavigationLink(destination: MapView()){
                            homeAppIconsView(homeIcons: homeIcons[0])
                        }
                        
                        homeAppIconsView(homeIcons: homeIcons[1])
                            .onTapGesture{
                                showCalendarView.toggle()
                            }
                    }
                }
                .padding()
            }
            .padding(.bottom,100)
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
        .sheet(isPresented: $showWelcomeScreen, content: {OnboardingView() })
        .sheet(isPresented: $showCalendarView, content: { CalendarView().environmentObject(taskModel) })
        .sheet(isPresented: $showNewsletterView, content: {NewsletterView()})
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
//MARK: Event Items
struct EventAppIcons: Identifiable{
    var id = UUID()
    var icon : String
    var eventTitle: String
    var eventBody: String
    var iconColor : String
    var iconBackground : String
}
var eventIconList = [
EventAppIcons(icon: "books.vertical",
              eventTitle: "Brand Challenge",
              eventBody: "This will be putting all the skills of the multiple degrees together to see how well you can work together to reach on brands vision",
              iconColor: "00b4d8",
              iconBackground: "f4f3ee"),
EventAppIcons(icon: "display",
              eventTitle: "Ludum Dare 50",
              eventBody: "Ludum Dare is an online event where games are made from scratch in a weekend. Check us out every April and October! ",
              iconColor: "eb5e28",
              iconBackground: "f4f3ee")
]
struct EventAppIconsCardView: View{
    var eventIcon : EventAppIcons
    var body: some View{
        VStack {
            HStack{
                Image(systemName: "record.circle.fill")
                    .font(.system(size: 20))
                Text(eventIcon.eventTitle)
                    .font(.system(size: 25))
                    .bold()
            }.hLeading()
                .padding(.bottom, 2)
            Text(eventIcon.eventBody)
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
                .foregroundColor(Color(hex: eventIcon.iconBackground))
                .overlay(
                    Image(systemName: eventIcon.icon)
                        .font(.system(size: 100))
                        .foregroundColor(Color(hex: eventIcon.iconBackground))
                        .background(
                            Color(hex: eventIcon.iconColor)
                                .clipShape(Circle())
                                .frame(width: 200, height: 250)
                        )
                        .hTrailing()
                        .offset(x:30)
                )
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        )
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
        .navigationBarHidden(true)
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


