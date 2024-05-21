//
//  PlaylistView.swift
//  SOONGEEZ
//
//  Created by 조세연 on 5/14/24.
//

import SwiftUI





struct PlaylistView: View {
    @Environment(\.dismiss) var dismiss
    
    @Binding var PlayList: [Music]
    
    @State private var showingAlert = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20){
            Text("\(Date(), formatter: Self.KoreanFormatter)의 플레이리스트")
                .font(.system(size: 24, weight: .semibold))
                .padding(.leading, 20)
            
            
            HStack{
                Spacer()
                Text("13분 25초")
                    .padding(.trailing, 20)
                    .font(.footnote)
                    .foregroundColor(.gray)
            }
            
            ZStack(alignment: .bottom){
                List{
                    ForEach($PlayList, id: \.id) { item in
                        HStack{
                            AsyncImage(url: item.wrappedValue.imageURL)
                                .cornerRadius(11)
                                .frame(width: 44, height: 44)
                            
                            VStack(alignment: .leading)
                            {
                                Text(item.wrappedValue.title)
                                Text(item.wrappedValue.artist)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            Spacer()
                            Text(item.wrappedValue.length)
                                .foregroundColor(.gray)
                                .font(.caption)
                            
                        }
                        
                    }
                    
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            //                            삭제
                        } label: {
                            Label("delete", systemImage: "trash")
                        }
                        
                        
                        Button(role: .cancel) {
                            //                            붐따
                        } label: {
                            Label("dislike", systemImage: "hand.thumbsdown.fill")
                        }
                        
                    }
                }
                .listStyle(.inset)
                .frame(maxHeight: 560)
                
                VStack{
                    Spacer()
                    HStack(alignment: .bottom){
                        Spacer()
                        Text("플레이리스트 종료하기")
                            .font(Font.custom("Inter", size: 14))
                            .underline()
                            .foregroundColor(.gray)
                            .onTapGesture {
                                showingAlert = true
                            }
                        Spacer()
                    }
                }
                .frame(width: 393, height: 87)
                .background(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .white.opacity(0), location: 0.00),
                            Gradient.Stop(color: .white, location: 1.00),
                        ],
                        startPoint: UnitPoint(x: 0.5, y: 0.18),
                        endPoint: UnitPoint(x: 0.5, y: 0.5)
                    ))
            }
        }
        
        .alert("플레이리스트 종료", isPresented: $showingAlert) {
            Button("종료하기", role: .destructive) {
                dismiss()
            }
            Button("취소", role: .cancel) {}
            
        } message: {
            Text("지금 재생하고 있는 플레이리스트를 종료하시겠습니까?")
        }
        
    }
    
    
}


extension PlaylistView{
    static let KoreanFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 dd일"
        return formatter
    }()
}





#Preview {
    PlaylistView(PlayList: .constant([
        Music(title: "Cookie", artist: "NeaJeans", length: "3:13", musicURL: "", imageURL: URL(string: "https://example.com/image1.jpg")!),
        Music(title: "starlight", artist: "Muse", length: "3:15", musicURL: "", imageURL: URL(string: "https://example.com/image2.jpg")!),
    ]))
}
