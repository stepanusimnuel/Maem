//
//  SaveSuccessAlert.swift
//  Maem
//
//  Created by Stepanus Imanuel on 07/07/26.
//

import SwiftUI

struct SaveSuccessAlert: View {
    @Binding var isPresented: Bool
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "checkmark.circle")
                .foregroundStyle(AppColor.greenDark)
                .font(AppFont.body(weight: .bold))
                .frame(width: 20, height: 20)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Berhasil menyimpan menu!")
                    .font(AppFont.body(weight: .bold))
                    .foregroundStyle(AppColor.neutralBlack)
                Text("Cek menu yang disimpan di menu Tersimpan.")
                    .font(AppFont.body(weight: .light))
            }
            
            Button {
                withAnimation(.easeInOut) {
                    isPresented = false
                }
            } label: {
                Image(systemName: "xmark")
                    .foregroundStyle(AppColor.neutralBlack)
                    .font(AppFont.body(weight: .regular))
                    .frame(width: 20, height: 20)
            }
        }
        .padding()
        .background(AppColor.greenLight)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
}

#Preview {
    SaveSuccessAlert(isPresented: .constant(false))
}
