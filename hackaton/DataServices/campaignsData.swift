//
//  campaignsData.swift
//  hackaton
//
//  Created by Ruben Dario Suarez Diaz on 06/03/24.
//

import Foundation
class campaignsData {
  static let campaigns: [Campaign] = [
      Campaign(name: "Limpieza de la comunidad",
                description: "Unete a tu comunidad para limpiar la plaza principal.",
                imageNames: ["reciclaje"],
                link: ""),
      Campaign(name: "Reforestación",
               description: "Ayuda a replantar árboles en áreas afectadas.",
               imageNames: ["arbol"],
               link: ""),
      Campaign(name: "Conservación del agua",
               description: "Promueve el uso responsable del agua en tu comunidad.",
               imageNames: ["agua"],
               link: ""),
      Campaign(name: "Reducción de residuos",
               description: "Aprende y enseña cómo generar menos basura en casa.",
               imageNames: ["basura"],
               link: ""),
      
      Campaign(name: "Donación de ropa",
               description: "Dona ropa que ya no uses a un albergue local.",
               imageNames: ["donacion"],
               link: ""),
      
      Campaign(name: "Huertos urbanos",
               description: "Cultiva tus propios alimentos en un espacio verde comunitario.",
               imageNames: ["huerto"],
               link: ""),
      Campaign(name: "Transporte sostenible",
               description: "Utiliza medios de transporte ecológicos como la bicicleta o el transporte público.",
               imageNames: ["bicicleta"],
               link: ""),
      Campaign(name: "Reciclaje y compostaje",
               description: "Separa tus residuos y aprende a compostar los orgánicos.",
               imageNames: ["compostaje"],
               link: ""),
      Campaign(name: "Protección de la fauna marina",
               description: "Reduce el uso de plástico y participa en limpiezas de playas.",
               imageNames: ["tortuga"],
               link: ""),
      Campaign(name: "Consumo responsable",
               description: "Compra productos locales y ecológicos, y evita el consumo excesivo.",
               imageNames: ["consumo"],
               link: ""),
      Campaign(name: "Educación ambiental",
               description: "Difunde información sobre la importancia de cuidar el medio ambiente.",
               imageNames: ["educacion"],
               link: ""),
    ]
  }
