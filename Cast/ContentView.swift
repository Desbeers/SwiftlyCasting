//
//  ContentView.swift
//  Cast
//
//  Created by Nick Berendsen on 16/12/2021.
//

import SwiftUI

import OpenCastSwift

struct ContentView: View {
    @EnvironmentObject var caster: Caster
    var body: some View {
        VStack {
            Text(caster.scanner.devices.first?.description ?? "None")
            Button(action: {
                cast()
            }, label: {
                Text("Cast UberMini")
            })
            Button(action: {
                goTV()
            }, label: {
                Text("Cast GoTV")
            })
        }
        .padding()
    }
    
    
    /// http://192.168.11.200:53544/playlist.m3u8
    ///
    
    
    func goTV() {
        let videoURL = URL(string: "https://5dc143936e9ae.streamlock.net/gotvsjoerd/gotvsjoerd/playlist.m3u8?token_endtime=1639694091&token_starttime=0&token_hash=VNgo9OC03oWofrr9hrGa2I7whYbaj4urvx92KHRBHRI=")!
        let posterURL = URL(string: "https://i.imgur.com/GPgh0AN.jpg")!
        
        // create a CastMedia object to hold media information
        let media = CastMedia(title: "Test Bars",
                              url: videoURL,
                              poster: posterURL,
                              contentType: "application/vnd.apple.mpegurl",
                              streamType: CastMediaStreamType.buffered,
                              autoplay: true,
                              currentTime: 0)
        
        caster.client!.launch(appId: CastAppIdentifier.defaultMediaPlayer) { [self] result in
            switch result {
            case .success(let app):
                // here you would probably call client.load() to load some media
                
                caster.client!.load(media: media, with: app) { result in
                    switch result {
                    case .success(let status):
                        print(status)
                        
                    case .failure(let error):
                        print(error)
                    }
                }
                
                // this media has been successfully loaded, status contains the initial status for this media
                // you can now call requestMediaStatus periodically to get updated media status
                
                
            case .failure(let error):
                print(error)
            }
            
        }
        
    }
    
    func cast() {
        let videoURL = URL(string: "http://192.168.11.200:53544/playlist.m3u8")!
        let posterURL = URL(string: "https://i.imgur.com/GPgh0AN.jpg")!
        
        // create a CastMedia object to hold media information
        let media = CastMedia(title: "Test Bars",
                              url: videoURL,
                              poster: posterURL,
                              contentType: "application/vnd.apple.mpegurl",
                              streamType: CastMediaStreamType.buffered,
                              autoplay: true,
                              currentTime: 0)
        
        caster.client!.launch(appId: CastAppIdentifier.defaultMediaPlayer) { [self] result in
            switch result {
            case .success(let app):
                // here you would probably call client.load() to load some media
                
                caster.client!.load(media: media, with: app) { result in
                    switch result {
                    case .success(let status):
                        print(status)
                        
                    case .failure(let error):
                        print(error)
                    }
                }
                
                caster.client!.requestMediaStatus(for: app) { result in
                  switch result {
                  case .success(let status):
                    print(status)

                  case .failure(let error):
                    print(error)
                  }
                }
                
                // this media has been successfully loaded, status contains the initial status for this media
                // you can now call requestMediaStatus periodically to get updated media status
                
                
            case .failure(let error):
                print(error)
            }
            
        }
    }
}
