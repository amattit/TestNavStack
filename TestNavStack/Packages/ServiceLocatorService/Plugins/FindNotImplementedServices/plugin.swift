//
//  File.swift
//  
//
//  Created by Михаил Серегин on 18.03.2023.
//

import PackagePlugin
import Foundation

@main
struct GenerateContributors: CommandPlugin {
    func performCommand(context: PackagePlugin.PluginContext, arguments: [String]) async throws {
        var contributors: [String.SubSequence] = []
        
        let urlString = FileManager.default.currentDirectoryPath
        guard let url = URL(string: urlString) else { return }

        var injections: [Injection] = []
        try recursiveScan(for: url).forEach {
            checkInjection(for: $0).forEach { value in
                injections.append(value)
            }
        }
        
        var registrations: [Registration] = []
        try recursiveScan(for: url).forEach({ url in
            checkServiceRegistration(for: url, and: injections).forEach {
                registrations.append($0)
            }
        })
        
        let diff = injections.filter { inj in
            !registrations.map(\.type).contains { $0 == inj.type }
        }
        
        for inj in diff {
            let notRegistered = "\(inj.type) is not registered!!!"
            contributors.append(.init(stringLiteral: notRegistered))
        }
        
        if contributors.isEmpty {
            contributors.append(.init(stringLiteral: "All Service is registered"))
        }
        
        try contributors.joined(separator: "\n").write(toFile: "NotImplemented.txt", atomically: true, encoding: .utf8)
    }
    
    func recursiveScan(for url: URL) throws -> [URL] {
        var files = [URL]()
        if let enumerator = FileManager.default.enumerator(at: url, includingPropertiesForKeys: [.isRegularFileKey], options: [.skipsHiddenFiles, .skipsPackageDescendants]) {
            for case let fileURL as URL in enumerator {
                do {
                    let fileAttributes = try fileURL.resourceValues(forKeys:[.isRegularFileKey])
                    let filename = getFilename(from: fileURL)
                    if fileAttributes.isRegularFile! && !filename.localizedCaseInsensitiveContains("plugin") {
                        files.append(fileURL)
                    }
                } catch { print(error, fileURL) }
            }
            print(files)
        }
        return files
            .filter { url in
                url.pathExtension == "swift"
            }
    }
    
    func checkInjection(for url: URL) -> [Injection] {
        guard let data = try? Data(contentsOf: url), let string = String(data: data, encoding: .utf8) else {
            return []
        }
        
        return string.split(separator: "\n")
            .map(String.init)
            .filter { value in
                value.localizedCaseInsensitiveContains("@Service")
            }
            .map { value in
                .init(file: getFilename(from: url), type: getType(from: value))
            }
    }
    
    func checkServiceRegistration(for url: URL, and injetion: [Injection]) -> [Registration] {
        guard let data = try? Data(contentsOf: url), let string = String(data: data, encoding: .utf8) else {
            return []
        }
        
        let lines = string.split(separator: "\n")
            .map(String.init)
            .filter { !$0.hasPrefix("//")}
        
        var result: [Registration] = []
        for injection in injetion {
            for line in lines {
                if line.matches("\(injection.type).self") {
                    result.append(.init(file: getFilename(from: url), type: getType(from: line)))
                }
            }
        }
        return result
    }
    
    func getType(from string: String) -> String {
        let type = string.split(separator: " ")
            .last ?? ""
        if string.last == ")" {
            return String(type.dropLast(1)).replacingOccurrences(of: ".self", with: "")
        } else {
            return String(type)
        }
    }
    
    func getFilename(from url: URL) -> String {
        "\(url.lastPathComponent)"
    }
}

struct Injection: Hashable, Equatable {
    let file: String
    let type: String
}

struct Registration: Hashable, Equatable {
    let file: String
    let type: String
}

extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}
