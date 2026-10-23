import SwiftUI

struct WalkSpot: Identifiable {
    let id: Int
    let line: String
    let station: String
    let exits: [Int]
    let task: String
    let image: String
    let color: Color
}


let walkSpots: [WalkSpot] = [
    WalkSpot(id: 1, line: "淡水信義線", station: "淡水", exits: [1, 2],
             task: "找一處喜歡的風景，拍下今天的天空。", image: "淡水", color: .red),
    WalkSpot(id: 2, line: "淡水信義線", station: "大安森林公園", exits: [1, 2],
             task: "尋找一片綠意，觀察三種不同形狀的葉子。", image: "大安森", color: .red),
    WalkSpot(id: 3, line: "松山新店線", station: "松山", exits: [1, 2],
             task: "散步尋找一家小店，記下最吸引你的招牌。", image: "松山", color: .green),
    WalkSpot(id: 4, line: "板南線", station: "龍山寺", exits: [1, 2],
             task: "尋找一個老建築，拍下一個有趣的細節。", image: "龍山寺", color: .blue),
    WalkSpot(id: 5, line: "中和新蘆線", station: "東門", exits: [1, 2],
             task: "走進一條沒走過的街道，找找喜歡的點心。", image: "東門", color: .orange),
    WalkSpot(id: 6, line: "文湖線", station: "大湖公園", exits: [1, 2],
             task: "找個舒服的地方停留，聽一分鐘周圍的聲音。", image: "大湖公園", color: .brown)
]

struct ContentView: View {
    @State private var result: WalkSpot?
    @State private var exitNumber = 1

    private let accent = Color(red: 0.17, green: 0.36, blue: 0.28)

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                VStack(alignment: .leading, spacing: 8) {
                    Label("TAIPEI · CITYWALK", systemImage: "figure.walk")
                        .font(.caption.weight(.bold))
                        .tracking(3)
                        .foregroundStyle(accent)
                    Text("下一站，隨心走。")
                        .font(.largeTitle.bold())
                    Text("讓捷運帶路，給日常一點小驚喜。")
                        .foregroundStyle(.secondary)
                }

                if let result {
                    WalkResultView(spot: result, exitNumber: exitNumber)
                } else {
                    VStack(spacing: 18) {
                        Image(systemName: "tram.fill")
                            .font(.system(size: 64))
                            .foregroundStyle(accent)
                            .accessibilityHidden(true)
                        Text("今天，去哪裡走走？")
                            .font(.title2.bold())
                        Text("按下按鈕，抽出你的散步小任務。")
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 48)
                    .padding(.horizontal)
                    .background(accent.opacity(0.08), in: RoundedRectangle(cornerRadius: 24))
                }

                Button(action: randomWalk) {
                    Label(result == nil ? "隨機出發" : "重新搖一次", systemImage: "shuffle")
                        .font(.headline)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                }
                .buttonStyle(.borderedProminent)
                .tint(accent)
                .controlSize(.large)

                Text("慢慢走，沿途的發現也是目的地。")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity)
            }
            .padding(24)
            .frame(maxWidth: 600)
            .frame(maxWidth: .infinity)
        }
        .background(Color(red: 0.96, green: 0.95, blue: 0.91).ignoresSafeArea())
    }

    private func randomWalk() {
        let choices = walkSpots.filter { $0.id != result?.id }

        let lines = ["淡水信義線", "松山新店線", "板南線", "中和新蘆線", "文湖線"]
        let availableLines = lines.filter { line in
            choices.contains { $0.line == line }
        }
        guard let line = availableLines.randomElement() else { return }
        let stations = choices.filter { $0.line == line }
        guard let station = stations.randomElement(),
              let exit = station.exits.randomElement() else { return }

        result = station
        exitNumber = exit
    }
}

struct WalkResultView: View {
    let spot: WalkSpot
    let exitNumber: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Text("今天的散步提案")
                    .font(.subheadline.bold())
                Spacer()
                Image(systemName: "sparkles")
            }

            Image(spot.image)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .accessibilityLabel("\(spot.station)的照片")

            Text("\(spot.station)站")
                .font(.largeTitle.bold())
            Label(spot.line, systemImage: "tram.fill")
                .foregroundStyle(spot.color)
            Label("\(exitNumber) 號出口", systemImage: "arrow.up.right.square")
            Divider()
            Label("你的散步任務", systemImage: "flag.fill")
                .font(.headline)
            Text(spot.task)
                .lineSpacing(5)
        }
        .padding(24)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.background, in: RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    ContentView()
}
