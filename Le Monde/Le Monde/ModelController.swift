//
//  ModelController.swift
//  Le Monde
//
//  Created by LETUE Erwann on 14/12/2017.
//  Copyright © 2017 Gobelins. All rights reserved.
//

import Foundation

enum State {
    case Header, Item, Title, Chapo, Permalink, Ignore
}

class ModelController: NSObject, XMLParserDelegate {
    
    var articles = Array<Article>()
    var state = State.Header
    
    func loadRSS() {
        if let url = URL(string: "http://www.lemonde.fr/rss/une.xml") {
            if let parser = XMLParser(contentsOf: url) {
                parser.delegate = self
                articles.removeAll()
                state = .Header
                
                DispatchQueue.global(qos: .userInitiated).async {
                    parser.parse()
                    DispatchQueue.main.async {
                        print("parsing done")
                        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "rssLoadedNotifications"), object: nil)
                    }
                }
            }
        }
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if state == .Header && elementName == "item" {
            state = .Item
        }
        if state != .Header {
            switch elementName {
            case "permalink":
                state = .Permalink
            case "item":
                articles.append(Article())
                state = .Ignore
            case "title":
                state = .Title
            case "description":
                state = .Chapo
            case "guid":
                state = .Permalink
            case "enclosure":
                articles.last?.imageAdress = attributeDict["url"]
                state = .Ignore
            default:
                state = .Ignore
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if state != .Header {
            state = .Ignore
        }
    }
    
    func safeConcat(_ s1: String?, with s2:String?) -> String {
        if let s2 = s2 {
            if let s1 = s1 {
                return s1 + s2
            } else {
                return s2
            }
        }
        return ""
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        switch state {
        case .Header, .Ignore:
            break;
        case .Title:
            articles.last!.title = safeConcat(articles.last!.title, with: string)
        case .Chapo:
            articles.last!.title = safeConcat(articles.last!.permalink, with: string)
        case .Permalink:
            articles.last!.title = safeConcat(articles.last!.chapo, with: string)
        default:
            break;
        }
    }
}
