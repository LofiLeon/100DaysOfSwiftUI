//
//  MeView.swift
//  HotProspects
//
//  Created by Leon Grimmeisen on 01.06.22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct MeView: View {
    @State private var name = "Anonymus"
    @State private var emailAddress = "you@yoursite.com"
    @State private var twitterHandle = "tweet"
    @State private var qrCode = UIImage()
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                    .textContentType(.name)
                    .font(.title)
                TextField("Email address", text: $emailAddress)
                    .textContentType(.emailAddress)
                    .font(.title)
                HStack {
                    Text("@")
                    TextField("Twitter handle", text: $twitterHandle)
                    Spacer()
                }
                Image(uiImage: qrCode)
                    .resizable()
                    .interpolation(.none)
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .contextMenu {
                        Button {
                            let imageSaver = ImageSaver()
                            imageSaver.writeToPhotoAlbum(image: qrCode)
                        } label: {
                            Label("Save to photos", systemImage: "square.and.arrow.down")
                        }
                    }
            }
            .navigationTitle("You")
            .onAppear(perform: updateCode)
            .onChange(of: name) {_ in updateCode() }
            .onChange(of: emailAddress) {_ in updateCode() }
            .onChange(of: twitterHandle) {_ in updateCode() }
        }
    }
    
    func updateCode() {
        qrCode = generateQrCode(from: "\(name)\n\(emailAddress)\n\(twitterHandle)")
    }
    
    func generateQrCode(from string : String) -> UIImage {
        filter.message = Data(string.utf8)
        
        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }
        return UIImage(systemName: "xmark.circle") ?? UIImage()
    }
}

struct MeView_Previews: PreviewProvider {
    static var previews: some View {
        MeView()
    }
}
