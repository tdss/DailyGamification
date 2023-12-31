//
//  Toast.swift
//  DailyGamification
//
//  Created by Gregory Moskaliuk on 11/07/2023.
//

import SwiftUI

struct ToastView: View {
    var type: ToastStyle
        var title: String
        var message: String
        var onCancelTapped: (() -> Void)
        var body: some View {
            VStack(alignment: .leading) {
                HStack(alignment: .top) {
                    Image(systemName: type.iconFileName)
                        .foregroundColor(type.themeColor)
                    
                    VStack(alignment: .leading) {
                        Text(title)
                            .font(.system(size: 14, weight: .semibold))
                            .foregroundColor(.black)
                        
                        Text(message)
                            .font(.system(size: 12))
                            .foregroundColor(Color.black.opacity(0.6))
                    }
                    
                    Spacer(minLength: 10)
                    
                    Button {
                        onCancelTapped()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundColor(Color.black)
                    }
                }
                .padding()
            }
            .background(Color.white)
            .overlay(
                Rectangle()
                    .fill(type.themeColor)
                    .frame(width: 6)
                    .clipped()
                , alignment: .leading
            )
            .frame(minWidth: 0, maxWidth: .infinity)
            .cornerRadius(8)
            .shadow(color: Color.black.opacity(0.25), radius: 4, x: 0, y: 1)
            .padding(.horizontal, 16)
        }
}

struct ToastModifier: ViewModifier {
    @Binding var toast: Toast?
    @State private var workItem: DispatchWorkItem?
    
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .overlay(
                ZStack {
                    mainToastView()
                        .offset(y: -30)
                }.animation(.spring(), value: toast)
            )
            .onChange(of: toast) { value in
                showToast()
            }
    }
    
    @ViewBuilder func mainToastView() -> some View {
        if let toast = toast {
            VStack {
                Spacer()
                ToastView(
                    type: toast.type,
                    title: toast.title,
                    message: toast.message) {
                        dismissToast()
                    }
            }
            .transition(.move(edge: .bottom))
        }
    }
    
    private func showToast() {
        guard let toast = toast else { return }
        
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        if toast.duration > 0 {
            workItem?.cancel()
            
            let task = DispatchWorkItem {
               dismissToast()
            }
            
            workItem = task
            DispatchQueue.main.asyncAfter(deadline: .now() + toast.duration, execute: task)
        }
    }
    
    private func dismissToast() {
        withAnimation {
            toast = nil
        }
        
        workItem?.cancel()
        workItem = nil
    }
}

struct Toast: Equatable {
    var type: ToastStyle
    var title: String
    var message: String
    var duration: Double = 3
}

enum ToastStyle {
    case error
    case warning
    case success
    case info
}

extension ToastStyle {
    var themeColor: Color {
        switch self {
        case .error: return Color.red
        case .warning: return Color.orange
        case .info: return Color.blue
        case .success: return Color.green
        }
    }
    
    var iconFileName: String {
        switch self {
        case .info: return "info.circle.fill"
        case .warning: return "exclamationmark.triangle.fill"
        case .success: return "checkmark.circle.fill"
        case .error: return "xmark.circle.fill"
        }
    }
}

extension View {
    func toastView(toast: Binding<Toast?>) -> some View {
        self.modifier(ToastModifier(toast: toast))
    }
}

struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(
                   type: .error,
                   title: "Error",
                   message: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. ") {}
    }
}
