//
//  GetUser.swift
//  Swift-API-Calls
//
//  Created by Fredson Silva on 28/03/24.
//

import Foundation

func getUser() async throws -> GitHubUser {
    let endpoint = "https://api.github.com/users/silvafredson"
    
    /// Cria uma objeto URL
    guard let url = URL(string: endpoint) else {
        throw GitHubError.invalidURL
    }
    
    /// URLSession recebe os dados da url, é um GET request, está apenas baixando os dados e retorna um tuple (data, response)
    let (data, response) = try await URLSession.shared.data(from: url)
    
    
    /// Se retornar 200 significa que esá tudo bem, se não será retornado ao usuátio um invalied response erro
    guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
        throw GitHubError.invalidResponse
    }
    
    /// Aqui
    do {
        let decoder = JSONDecoder()
        /// Aqui foi usado o  .convertFromSnakeCase  que  converte de snake_case para camelCase que é o padrão utilizado em Swift
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(GitHubUser.self, from: data)
    } catch {
        throw GitHubError.invalidData
    }
}

