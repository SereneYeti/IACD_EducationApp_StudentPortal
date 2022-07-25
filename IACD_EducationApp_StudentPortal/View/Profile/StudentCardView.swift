    //
    //  StudentCardView.swift
    //  IACD_EducationApp_StudentPortal
    //
    //  Created by IACD-013 on 2022/07/23.
    //

import SwiftUI

struct StudentCardView: View {
    @State var showCard: Bool = false
    var testStu = testData[0]
    var body: some View {
        VStack {
            VStack{
                HStack{
                    Button {
                        
                    } label: {
                        Image(systemName: "plus.app")
                            .foregroundColor(.primary)
                            .font(.system(size: 35, weight: .light))
                    }
                    .padding(.leading,10)
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Student ID")
                            .font(.caption2)
                        Text(testStu.id)
                            .font(.caption2)
                    }
                    .padding(.trailing)
                    
                }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text(testStu.firstName)
                            .font(.system(size: 45, weight: .bold))
                        Text(testStu.lastName)
                            .font(.system(size: 45, weight: .bold))
                    }
                    .hLeading()
                }
                .padding()
                
                HStack{
                    Text("Student Number:")
                        .font(.system(size: 15))
                    Spacer()
                    Text(String(testStu.studentNum))
                        .font(.system(size: 20,weight: .bold))
                }
                .padding()
                HStack{
                    Text("Qualification : ")
                    Spacer()
                    VStack {
                        Text("Game Design")
                            .font(.system(size: 20,weight: .bold))
                    }
                }
                .padding()
            }
            .offset(y: showCard ?  700: 0)
            .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0), value: showCard)
            Spacer()
            Rectangle()
//                .offset(y: showCard ? -100 : 0)
                .frame(width: screen.width - 20, height: showCard ? screen.height + 250 : screen.height - 450 )
                .cornerRadius(showCard ? 30 : 0)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay {
                    VStack {
                        HStack(alignment: .top) {
                         
                            Image("qrCode")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(.white)
                                .padding()
                        }
                        Spacer()
                            .frame(height: 30)
                        
                        HStack {
                            VStack(alignment: .leading){
                                Text("Degree")
                                Text(String(testStu.studentNum))
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
                        .offset(y: showCard ? -50 : -20)
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
