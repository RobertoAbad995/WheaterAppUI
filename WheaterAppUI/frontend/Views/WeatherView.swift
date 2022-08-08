//
//  ContentView.swift
//  WheaterAppUI
//
//  Created by Consultant on 8/1/22.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject private var vm = WeatherAppViewModel()
    
    
    
    var body: some View {
        ZStack{
            BackgroundView(isNight: $vm.isNight)
            
            
            
                VStack{
                    
                    if(vm.weather != nil){
                        Text(vm.weather?.region ?? "Querétaro, Qro")
                            .font(.system(size: 32, weight: .medium, design: .default))
                            .foregroundColor(.white)
                            .padding()
                        
                        
                        VStack(spacing: 10){
                            AsyncImage(url: URL(string: vm.weather?.currentConditions.iconURL ?? ""))
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 180, height: 170, alignment: .center)
        //                    Image(systemName: vm.isNight ? "moon.stars.fill": "cloud.sun.fill")
        //                        .renderingMode(.original)
        //                        .resizable()
        //                        .aspectRatio(contentMode: .fit)
        //                        .frame(width: 180, height: 180)
                            
                            Text("\(vm.weather?.currentConditions.temp.getStringFormat() ?? "")")
                                .font(.system(size: 30, weight: .medium))
                                .foregroundColor(.white)
                        }
                        .padding(.bottom, 70)
                        
                       
                        HStack(spacing: 20){

                                
        //                    }
                        }.frame(height: 100)
                        
                        ScrollView(.horizontal) {
                            HStack(spacing: 20){
                                ForEach(vm.weather?.nextDays ?? [], id: \.self.day) { day in
                                    weatherDayView(dayOfTheWeek: day)
                                }
                            }
                        }
                        .frame(height: 40)
                        .padding([.trailing, .leading], 10)
                        
                        Spacer()
                    }
                    
                    if (vm.loading) {
                        ProgressView()
                            .padding(.bottom,50)
                            .scaleEffect(5)
                    }
                    
                    //REQUEST OPTIONS
                    ScrollView(.horizontal){
                        
                        HStack{
                            Button{
                                vm.isNight.toggle()
                            }label: {
                                Text("Change day time")
                                    .frame(width: 150, height: 40)
                                    .background(Color.white)
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .cornerRadius(10)
                            }
                            
                            Button{
                                vm.weather = nil
                            }label: {
                                Text("Clear results")
                                    .frame(width: 150, height: 40)
                                    .background(Color.white)
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .cornerRadius(10)
                            }
                            
                            Button{
                                vm.fetchWeather(with: .URLSession)
                            }label: {
                                Text("Get with URLSession")
                                    .frame(width: 150, height: 40)
                                    .background(Color.white)
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .cornerRadius(10)
                            }
                            
                            Button{
                                vm.fetchWeather(with: .Combine)
                            }label: {
                                Text("Get with Combine")
                                    .frame(width: 150, height: 40)
                                    .background(Color.white)
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .cornerRadius(10)
                            }
                            
                            Button{
                                vm.fetchWeather(with: .AlamoFire)
                            }label: {
                                Text("Get with Combine")
                                    .frame(width: 150, height: 40)
                                    .background(Color.white)
                                    .font(.system(size: 10, weight: .bold, design: .default))
                                    .cornerRadius(10)
                            }
                        }
                    }
                    .padding(.bottom, 20)
                }
            
            
            
            
           
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct weatherDayView: View {
    
    var dayOfTheWeek: WeatherDay
    
    var body: some View {
        VStack{
            Text(dayOfTheWeek.day)
                .font(.system(size: 10, weight: .medium, design: .default))
                .foregroundColor(.white)
            
            AsyncImage(url: URL(string: dayOfTheWeek.iconURL))
//                .renderingMode(.original)
//                .resizable()
//                .aspectRatio(contentMode: .fit)
                .frame(width: 40, height: 40)
            
            Text("Max \(dayOfTheWeek.maxTemp.c)º \\ \(dayOfTheWeek.maxTemp.f)")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
            Text("Min \(dayOfTheWeek.minTemp.c)º \\ \(dayOfTheWeek.minTemp.f)")
                .font(.system(size: 20, weight: .medium))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNight: Bool
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue, isNight ? .gray : Color("lightBlue")]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
        .edgesIgnoringSafeArea(.all)
    }
}
