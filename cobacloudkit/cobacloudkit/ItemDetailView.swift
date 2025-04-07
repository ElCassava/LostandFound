//
//  ItemDetailView.swift
//  cobacloudkit
//
//  Created by Sessario Ammar Wibowo on 02/04/25.
//

import SwiftUI

struct ItemDetailView: View {
    @Binding var isAdmin: Bool
    @Environment(\.modelContext) private var modelContext
    @State private var claimerName: String = ""
    @State private var isClaiming: Bool = false
    @Environment(\.dismiss) private var dismiss
    let item: Item

    private func claimItem() {
        guard !claimerName.isEmpty else { return }

        item.claimer = claimerName
        item.isClaimed = true
        item.dateClaimed = Date()

        do {
            try modelContext.save()
        } catch {
            print("Failed to save claim: \(error)")
        }

        isClaiming = false
        dismiss()
    }

    func loadImage(named name: String) -> UIImage? {
        let fileURL = FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(name)

        if let fileURL = fileURL, let imageData = try? Data(contentsOf: fileURL) {
            return UIImage(data: imageData)
        }
        return nil
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                if let image = loadImage(named: item.imageName) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        .shadow(radius: 5)
                        .padding(.horizontal)
                }
                VStack(spacing: 8) {
                    Text(item.itemName)
                        .font(.title.bold())
                        .multilineTextAlignment(.center)

                    Text(item.category)
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("Found at: \(item.locationFound)")
                        .font(.subheadline)
                        .foregroundColor(.gray)

                    Text("Date Found: \(formattedDate(item.dateFound))")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                .padding(.horizontal)

                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: item.isClaimed ? "checkmark.circle.fill" : "xmark.circle.fill")
                            .foregroundColor(item.isClaimed ? .green : .red)
                            .font(.title3)
                        
                        Text(item.isClaimed ? "Claimed" : "Not Claimed")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }

                    if item.isClaimed {
                        Text("Claimer: \(item.claimer ?? "Unknown")")
                            .font(.subheadline)
                            .foregroundColor(.gray)

                        if let dateClaimed = item.dateClaimed {
                            Text("Date Claimed: \(formattedDate(dateClaimed))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                .padding(.horizontal)

                VStack(alignment: .leading, spacing: 10) {
                    Text("Description")
                        .font(.headline)
                    
                    Text(item.itemDescription)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color(.systemGray6)))
                .padding(.horizontal)

                if isAdmin {
                    if !item.isClaimed {
                        if isClaiming {
                            VStack(spacing: 10) {
                                TextField("Enter Claimer Name", text: $claimerName)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                                    .padding(.horizontal)

                                Button(action: claimItem) {
                                    Text("Submit")
                                        .font(.headline)
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color.blue)
                                        .foregroundColor(.white)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .shadow(radius: 3)
                                }
                                .padding(.horizontal)
                            }
                            .padding()
                        } else {
                            Button(action: { isClaiming = true }) {
                                Text("Claim Item")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.blue)
                                    .foregroundColor(.white)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    .shadow(radius: 3)
                            }
                            .padding(.horizontal)
                        }
                    }
                    
                }
                
            }
            .padding(.vertical)
        }
        .navigationTitle("Item Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

