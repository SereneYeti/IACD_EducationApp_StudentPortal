//
//  DegreeModule.swift
//  IACD_EducationApp_StudentPortal
//
//  Created by IACD-013 on 2022/07/24.
//

import Foundation

struct Module: Codable, Hashable{
    var name: String?
    var lecturer: String?
    var color: String?
    var image: String?
    var description: String?
    var Content: [String]?
    var ContentTitles: [String]?
}

let  testModule = [
    Module(name: "Game Design",
           lecturer: "Bob",
           color: "a8dadc",
           image: "https://dl.dropboxusercontent.com/s/4im1ka2yb310dvb/Game%20analytics-rafiki.png?dl=0",
           description: "Game designers focus on the function of a game, creating systems, rules, and gameplay, and help with world-building (story and IP) to ensure it's playable, fun, and engaging. ",
           Content: ["This module introduces the basic concepts, components and practices of games art and design focusing on practice that is underpinned by research and imaginative experimentation. They will practically and analytically investigate the fundamental games design principles through a series of projects that will explore and begin to define working methods and studio practices.",
                    "This module introduces the basic concepts and components of sequence and narrative within illustration, graphic design animation and games art. Project briefs enable you to explore story telling, form, pacing, play, presentation and audience interaction. You'll also be introduced to basic working methods and studio practices whilst exploring emerging digital delivery formats.",
                    "This module provides an introduction to the foundations of games art and design. You'll gain the core planning skills needed to create a simple digital game, develop creative thinking skills, and explore creative approaches needed to create art work for digital games.",
                    "This module includes a broad history of visual communication. You'll focusing on new technologies and digital media, the impact the digital revolution has on the culture of graphic design, illustration, art, film, as well as the development of animation, games art, and social media."],
           ContentTitles: ["Games Art and Design Principles and Practice",
                          "Sequence and Narrative",
                          "Introduction to Games Design",
                          "Historical and Critical Studies"])

]
