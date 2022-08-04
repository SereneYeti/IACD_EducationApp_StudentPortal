    //
    //  StudentCardView.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/07/23.
    //

import SwiftUI

struct StudentCardView: View {
    @State var showCard: Bool = false
    @State var testStu = testData[0]
    var body: some View {
        VStack {
            VStack{
                HStack{
//                    Button {
//                        //MARK: ADD student Card and generate QR code
//                    } label: {
//                        Image(systemName: "plus.app")
//                            .foregroundColor(.primary)
//                            .font(.system(size: 35, weight: .light))
//                    }
//                    .padding(.leading,10)
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Student ID")
                            .font(.caption2)
                        Text(testStu.id)
                            .font(.caption2)
                    }
                    .padding(.trailing)
                    
                }
                Spacer()
                    .frame(height:  40)
                HStack {
                    
                    VStack(alignment: .leading) {
                        Text(testStu.firstName)
                            .font(.system(size: 70, weight: .bold))
                        Text(testStu.lastName)
                            .font(.system(size: 40))
                    }
                    .hLeading()
                }
                .padding()
            }
            .offset(y: showCard ?  700: 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0), value: showCard)
            Spacer()
            Rectangle()
                //                .offset(y: showCard ? -100 : 0)
                .frame(width: screen.width - 20, height: showCard ? screen.height + 150 : screen.height - 450)
                .cornerRadius(showCard ? 30 : 0)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay {
                    VStack {
                            //MARK: Inner card view
                        InnerStudentCardView(showCard: $showCard, testStu: $testStu)
                        Spacer()
                            .frame(height: 10)
                        HStack {
                            VStack(alignment: .leading){
                                Text(showCard ? "Hide":"Show Student Card")
                            }
                            .foregroundColor(.white)
                            Spacer()
                            Button {
                                self.showCard.toggle()
                            } label: {
                                Image(systemName: showCard ?   "minus.circle" : "plus.circle.fill" )
                                    .foregroundColor(.white)
                                    .font(.system(size: 35,weight: .light))
                                    .rotationEffect(Angle(degrees: showCard ? 360 : 180))
                            }
                        }
                        .offset(y: showCard ? -30 : -50)
                        .padding()
                    }
                }
                .animation(.spring(response: 0.6, dampingFraction: 0.9, blendDuration: 0.5), value: showCard)
        }
    }
}

struct StudentCardView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCardView()
    }
}

struct InnerStudentCardView: View {
    @Binding var showCard: Bool
    @Binding var testStu : Student
    var body: some View {
        VStack(spacing: 10){
            HStack(spacing: 20){
                Text(testStu.firstName)
                    .font(.system(size: 36, weight: .bold))
                Text(testStu.lastName)
                    .font(.system(size: 36, weight: .bold))
            }
            .padding()
            Spacer()
                .frame(height: showCard ? 10 : 0)
            HStack{
                Text("Course ")
                Spacer()
                Text("Game Design")
            }
            .padding()
            HStack{
                Text("Student Number")
                    .fontWeight(.light)
                Spacer()
                Text(String(testStu.studentNum))
            }
            .padding()
            HStack {
                Text("ID Number")
                Spacer()
                Text(String(23456789098765))
            }
            .padding()
            HStack{
                Text("Year of issue ")
                Spacer()
                Text(String(Date().formatted(.dateTime.day().month().year())))
            }
            .padding()
        }
        .foregroundColor(showCard ? .white : .black)
        .offset(y: showCard ? -280 : 10)
        .overlay {
            
            Image("qrCode")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                .padding()
                .frame(width: showCard ? 300 : 250, height: showCard ? 300 : 250)
                .offset(y: showCard ? screen.height - 800 : screen.height - 840)
        }
    }
}
