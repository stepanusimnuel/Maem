//
//  TenantView.swift
//  Maem
//
//  Created by Stepanus Imanuel on 09/07/26.
//

import SwiftUI

struct TenantView: View {
    let segmentedControlOption = ["Anak", "Semua Menu"]
    @State var userOption: String = "Anak"
    
    init() {
        UISegmentedControl.appearance().setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ], for: .selected)
        
        UISegmentedControl.appearance().setTitleTextAttributes([
            .font: UIFont.systemFont(ofSize: 14, weight: .regular)
        ], for: .normal)
    }
    
    var body: some View {
        ZStack {
            AppColor.red50.ignoresSafeArea()
            
            VStack (alignment: .leading, spacing: 0) {
                
                
                Text("Menu Tenant Ini")
                    .font(AppFont.title(weight: .bold))
                    .padding()
                
                TenantInfoCard()
                
                Picker("Pilih", selection: $userOption) {
                    ForEach(segmentedControlOption, id: \.self) { op in
                        Text(op).tag(op)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                Spacer()
            }
        }
        
    }
}

#Preview {
    TenantView()
}
