//
//  ContentView.swift
//  SwiftUIQRCodeGenerator
//
//  Created by Angelos Staboulis on 20/7/24.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
struct ContentView: View {
    @State var image:UIImage?
    @State var showCode:Bool
    var body: some View {
        VStack {
            Text("QRCode Generator").font(.largeTitle)
            VStack{
                if showCode{
                    Image(uiImage:image ?? UIImage())
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 195)
                }

            }.padding(UIScreen.main.bounds.height / 5.0)
            Spacer()
            VStack{
                Button {
                    showCode.toggle()
                    image = generateQRCode(message: "Test")
                } label: {
                    Text("Generator QRCode").frame(width:300,height:45)
                }
            }
            
        }

    }
    func generateQRCode(message:String)->UIImage?{
        let context = CIContext()
        let filter = CIFilter.qrCodeGenerator()
        filter.message = Data(message.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

#Preview {
    ContentView(showCode: false)
}
