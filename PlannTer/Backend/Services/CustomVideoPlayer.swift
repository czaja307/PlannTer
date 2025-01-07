import SwiftUI
import WebKit

struct WebVideoPlayer: UIViewRepresentable {
    let videoURL: String
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        return webView
    }
    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: videoURL) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }
}

struct CustomVideoPlayer: View {
    var sourceToPlay: String
    var descriptionText: String
    @Binding var videoToggle: Bool
    
    init(sourceToPlay: String, descriptionText: String = "Embedded Video", videoToggle: Binding<Bool>) {
        self.sourceToPlay = sourceToPlay
        self.descriptionText = descriptionText
        self._videoToggle = videoToggle
    }
    var body: some View {
        ZStack {
            if videoToggle {
                Color.black.opacity(0.3)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        videoToggle = false
                    }
            }
            if videoToggle {
                VStack {
                    ZStack(alignment: .topTrailing) {
                        WebVideoPlayer(videoURL: sourceToPlay)
                            .frame(width: 350, height: 300)
                            .cornerRadius(12)
                            .shadow(radius: 10)
                        Button(action: {
                            videoToggle = false
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(.white)
                                .padding(10)
                        }
                    }
                }
            }
        }
        .animation(.easeInOut, value: videoToggle)
    }
}
