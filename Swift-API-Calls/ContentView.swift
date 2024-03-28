//
//  ContentView.swift
//  Swift-API-Calls
//
//  Created by Fredson Silva on 26/03/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var user: GitHubUser?
    
    var body: some View {
        VStack(spacing: 20) {
            AsyncImage(url: URL(string: user?.avatarUrl ?? "")) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .clipShape(Circle())
            } placeholder: {
                Circle()
                    .foregroundColor(.secondary)
            }
            .frame(width: 120, height: 120)

            Text(user?.name ?? "Place holder")
                .bold()
                .font(.title3)
            Text(user?.bio ?? "Bio place holder")
                .padding()
            Spacer()
        }
        .padding()
        .task {
            do {
                user = try await getUser()
            } catch GitHubError.invalidURL {
                print("Invalid URL")
            } catch GitHubError.invalidResponse {
                print("Invalid response")
            } catch GitHubError.invalidData {
                print("Invalid data")
            } catch {
                print("Unexpected error")
            }
        }
    }
}

#Preview {
    ContentView()
}
