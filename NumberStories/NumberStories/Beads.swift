//
//  Beads.swift
//  NumberStories
//
//  Created by Rankovic, Marko (Developer) on 02/12/2017.
//  Copyright © 2017 Marko Rankovic. All rights reserved.
//

import SpriteKit

let BeadPositions: [String : [CGPoint]] = {
    
    var positions: [String : [CGPoint]] = [:]
    
    positions["0"] = "4.01836, 170.326; -41.6145, 163.14; -79.998, 140.278; -107.876, 103.587; -123.32, 61.1526; -131.834, 18.3417; -130.227, -24.518; -122.75, -67.7924; -105.584, -107.076; -79.9539, -139.068; -43.5343, -161.717; -1.02702, -168.81; 41.9671, -163.231; 79.0197, -140.921; 106.15, -109.234; 122.322, -68.9702; 130.199, -27.274; 131.758, 15.7514; 125.595, 56.7838; 112.572, 95.3963; 90.7542, 130.182; 53.8925, 158.621".toPositions()
    
    positions["1"] = "-94.2031, 122.82; -59.1836, 123.869; -26.891, 133.309; 3.0, 151.331; 3.0, 112.517; 3.0, 73.9038; 3.0, 35.448; 3.0, -2.9729; 3.0, -41.0023; 3.0, -80.465; 3.0, -119.837; 3.0, -158.773".toPositions()
    
    positions["2"] = "-107.809, 75.5859; -103.998, 111.205; -79.7722, 141.811; -47.7265, 158.523; -10.2523, 164.347; 27.2988, 157.675; 61.3318, 141.21; 86.2091, 111.173; 96.2639, 74.5287; 92.9895, 35.9278; 74.0955, 1.34586; 43.7131, -23.6957; 10.478, -42.3686; -23.3535, -60.5488; -57.4038, -77.6407; -90.2264, -99.4554; -113.109, -121.364; -122.295, -151.255; -85.4602, -151.255; -47.6562, -151.255; -9.89098, -151.255; 27.5388, -151.255; 66.5502, -151.255; 104.361, -151.255".toPositions()
    
    positions["3"] = "-102.526, 129.335; -96.4393, 166.601; -74.4743, 198.827; -39.9149, 214.222; -2.67287, 220.631; 35.0247, 216.336; 68.0707, 197.764; 90.2183, 166.098; 97.9142, 128.622; 92.4176, 90.077; 71.0016, 58.1762; 39.9895, 34.687; 5.37786, 12.9479; 42.6468, 1.18425; 77.3555, -14.2411; 103.741, -43.9368; 116.671, -80.198; 114.584, -117.861; 102.693, -154.524; 78.2189, -184.471; 46.259, -207.236; 8.70326, -217.841; -31.3049, -219.496; -71.237, -209.981; -105.091, -188.442; -118.141, -149.822".toPositions()
    
    positions["4"] = "29.2087, 173.534; 4.79396, 144.333; -20.5396, 112.625; -46.4598, 81.0707; -72.8221, 49.5427; -98.5829, 19.343; -124.418, -12.323; -143.813, -39.577; -147.496, -66.804; -109.623, -66.804; -70.4093, -66.804; -30.132, -66.804; 10.1858, -66.804; 51.2813, -66.804; 90.6111, -66.804; 130.997, -66.804; 67.622, 55.295; 67.622, 16.5837; 67.622, -24.2151; 67.622, -106.904; 67.622, -145.751; 67.622, -183.041; 67.622, -217.771".toPositions()
    
    positions["5"] = "-82.5725, 168.085; -86.9968, 128.649; -91.7759, 89.1174; -96.297, 49.9498; -101.832, 11.5683; -66.9253, 30.7551; -28.4081, 45.9625; 10.7303, 49.9424; 50.2006, 37.5552; 83.7629, 13.0042; 105.29, -21.7266; 114.026, -62.4541; 111.359, -105.96; 98.487, -145.483; 73.1563, -177.992; 41.2196, -201.611; 1.25497, -213.209; -45.4834, -211.456; -85.6844, -196.674; -109.1, -162.58; -117.276, -127.659; -78.1249, 200.19; -33.1878, 200.19; 11.2139, 200.19; 60.1234, 200.19; 108.863, 200.19".toPositions()
    
    positions["6"] = "79.4257, 219.729; 39.4562, 207.485; -0.434486, 189.738; -34.2417, 165.006; -63.7607, 135.543; -87.659, 98.5441; -105.486, 57.8155; -116.112, 14.9704; -120.838, -28.5256; -119.501, -72.1078; -113.551, -115.128; -99.949, -153.161; -77.6528, -186.833; -45.5676, -212.157; -7.20549, -221.166; 33.6682, -217.504; 70.1226, -198.027; 97.1447, -166.576; 113.743, -128.913; 119.446, -86.9815; 114.695, -44.8048; 99.606, -7.27423; 73.7971, 22.5792; 37.1165, 40.4601; -3.9194, 43.0974; -44.0382, 31.4912; -75.6823, 11.6745".toPositions()
    
    positions["7"] = "-121.527, 201.483; -72.6053, 201.483; -21.9048, 201.483; 29.6466, 201.483; 81.6973, 201.483; 127.139, 201.483; 107.458, 161.552; 87.3956, 122.802; 65.3013, 81.6364; 43.5229, 39.6469; 21.9647, -0.923737; 0.217651, -43.5665; -21.1186, -84.5174; -42.7542, -125.684; -65.5243, -169.073; -88.3591, -212.566".toPositions()
    
    positions["8"] = "10.6622, 224.112; -37.2194, 217.782; -75.0942, 196.145; -101.465, 162.807; -111.826, 121.997; -98.0369, 76.9312; -64.4284, 41.8074; -24.4531, 19.2458; 15.6969, 1.15215; 57.5019, -18.9736; 96.5388, -44.556; 123.799, -85.4563; 126.405, -130.139; 109.904, -171.568; 79.7635, -202.771; 36.8107, -220.813; -9.45947, -224.912; -53.7285, -215.947; -91.2944, -192.93; -115.943, -164.354; -129.263, -127.355; -127.255, -82.9421; -107.656, -44.8654; -71.9858, -13.8803; 63.4035, 27.1985; 93.2678, 58.1183; 111.056, 97.8776; 109.836, 142.956; 93.0425, 182.314; 61.2509, 211.2".toPositions()
    
    positions["9"] = "-16.1954, 220.987; -56.8104, 206.711; -88.3462, 177.401; -110.115, 138.527; -118.455, 95.7711; -117.593, 54.2627; -103.703, 12.1387; -77.4631, -20.1602; -39.8028, -40.9597; 4.45871, -42.2495; 47.0371, -29.7186; 81.9658, -8.16525; 119.832, 21.1479; 118.986, 63.4943; 113.717, 111.754; 97.6288, 155.986; 70.2242, 193.817; 31.8346, 217.517; 115.054, -19.9941; 104.388, -61.0096; 87.4865, -99.0772; 63.5286, -133.574; 31.8327, -165.368; -2.13733, -188.326; -38.4718, -205.174; -82.4855, -218.014".toPositions()
    
    positions["10"] = "-145.664, 109.035; -114.875, 127.684; -90.754, 155.456; -90.754, 112.821; -90.754, 69.982; -90.754, 26.9207; -90.754, -17.9182; -90.754, -61.5822; -90.754, -106.267; -90.754, -152.872; 61.5646, 166.489; 25.0061, 145.728; 6.60667, 106.674; -2.32243, 60.4904; -5.3885, 14.2027; -5.00633, -32.6108; 0.853531, -77.8184; 12.7798, -121.793; 35.4689, -158.303; 77.1409, -164.418; 106.123, -134.123; 122.419, -95.0951; 127.305, -52.5034; 130.48, -9.26814; 129.023, 35.6281; 124.683, 75.5358; 115.088, 111.224; 98.9379, 144.661".toPositions()
    
    positions["equals"] = "-139.508, 59.743; -93.3758, 59.743; -47.4719, 59.743; -1.32217, 59.743; 44.8328, 59.743; 93.2989, 59.743; 140.258, 59.743; -139.632, -58.43; -95.3863, -58.43; -47.6166, -58.43; -0.586594, -58.43; 47.2641, -58.43; 91.4856, -58.43; 140.131, -58.43".toPositions()
    
    positions["plus"] = "0.0, 47.3895; 0.0, 0.0; 0.0, -47.3988; -43.72, 0.0; 47.1524, 0.0".toPositions()
    
    return positions
}()


class Beads: SKScene {
    
    override func didMove(to: SKView) {
        let positions = self["bead"].map{ "\($0.position.x), \($0.position.y)" }.joined(separator: "; ")
        print("positions[\"10\"] = \"\(positions)\".toPositions()")
    }
}

extension String {
    
    func toPositions() -> [CGPoint] {
        var positions: [CGPoint] = []
        let pointStrings = components(separatedBy: "; ")
        for pointString in pointStrings {
            let xy = pointString.components(separatedBy: ", ")
            guard xy.count == 2, let x = Double(xy.first!), let y = Double(xy.last!) else {
                fatalError("Failed to parse '\(xy)'")
            }
            positions.append(.init(x: x, y: y))
        }
        return positions
    }
}


