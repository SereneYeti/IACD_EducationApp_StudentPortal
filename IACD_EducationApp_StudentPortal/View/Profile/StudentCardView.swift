//
//  StudentCardView.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/23.
//

import SwiftUI

struct StudentCardView: View {
    var testStu = testData[0]
    var body: some View {
        VStack {
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
                    Text("Digital Design")
                        .font(.system(size: 20,weight: .bold))
                }
            }
            .padding()
            Spacer()
            Rectangle()
                .frame(width: screen.width - 20, height: 350)
                .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                .overlay {
                    VStack {
                        HStack(alignment: .top) {
                            VStack {
                                Text("Degree")
                                Text("Year of student")
                            }
                            .foregroundColor(.white)
                            .padding(5)
                            .padding(.top,10)
                            
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
                                
                            } label: {
                                Image(systemName: "plus.circle.fill")
                                    .foregroundColor(.white)
                                    .font(.system(size: 35,weight: .light))
                            }
                            
                        }
                        .padding()
                    }
                    
                }
            
                
        }
    }
}

struct StudentCardView_Previews: PreviewProvider {
    static var previews: some View {
        StudentCardView()
    }
}
