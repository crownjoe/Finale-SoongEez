//
//  MusicView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI
import AVKit

struct MusicView: View {
    @Environment(\.dismiss) var dismiss
    @State var showPlayList = false

    @ObservedObject var PlayerModel: AudioPlayerViewModel
    @Binding var finish: Bool

    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffsetY: CGFloat = 0
    
    var body: some View {

        ZStack {
            ZStack{
                Color.customGray200.edgesIgnoringSafeArea(.all)
                
                Image("backgroundDecoration") //백그라운드 이미지 들어갈 것
                    .resizable()
                    .scaledToFit()
                    .frame(width:393, height:486)
                    .padding(.top, 330)
                    .ignoresSafeArea()
                
                VStack(spacing:0){
                    TopLogo
                    CurrentOrder
                    PlayerView(PlayerModel: PlayerModel)
                    Text("플리보기")
                        .onTapGesture { showPlayList = true }
                    Spacer()
                }
            }
            PlaylistView(PlayList: $PlayerModel.PlayList, finish: $finish)
//                .padding(.top, 40)
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -150 {
                                    endingOffsetY = -startingOffsetY
                                    currentDragOffsetY = .zero
                                } else if endingOffsetY != 0 && currentDragOffsetY > 150 {
                                    endingOffsetY = .zero
                                    currentDragOffsetY = .zero
                                } else {
                                    currentDragOffsetY = .zero
                                }
                            }
                        })
                )
        }
        .ignoresSafeArea(edges: .bottom)
        
    }
    
    
    
    var TopLogo: some View {
        HStack{
            Image("img_logo")//텍스트 로고
                .resizable()
                .scaledToFit()
                .frame(width:69, height: 21)
                .padding([.top], 62)
                .padding([.bottom], 24)
                .padding([.horizontal], 20)
            Spacer()
        }
    }
    
    var CurrentOrder: some View {
        VStack(spacing: 0){
            HStack{
                Text("오늘의 플레이리스트")
                    .padding([.bottom],5)
                Spacer()
            }
            HStack{
                Text("\(PlayerModel.currentSongIndex+1)번째 곡이에요")//data:노래 순서
                Image(systemName: "music.note")
                Spacer()
            }
        }
        .font(.system(size: 24, weight:.bold))//semibold로하면 피그마랑 묘하게 안맞음
        .padding([.horizontal],20)
        .padding([.bottom],24)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        // @StateObject 사용
        MusicView(PlayerModel: AudioPlayerViewModel(
            PlayList: [
            Music(title: "Cookie", artist: "가수1", length: "3:13", musicURL: "music_test", imageURL: URL(string: "https://example.com/image1.jpg")!),
            Music(title: "starlight", artist: "가수2", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!),  ],
            lastSong: Music(title: "집에 언제가노", artist: "김은정", length: "3:15", musicURL: "music_test", imageURL: URL(string: "https://example.com/image2.jpg")!)),
                  finish: .constant(false))
    }
}


