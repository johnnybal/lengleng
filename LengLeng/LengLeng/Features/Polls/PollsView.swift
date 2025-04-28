import SwiftUI
import UIKit

struct PollsView: View {
    @EnvironmentObject var userService: UserProfileSystem
    @EnvironmentObject var flamesService: FlamesService
    @StateObject private var viewModel = PollsViewModel()
    @State private var currentPollIndex: Int = 0
    @State private var selectedOptionId: String? = nil
    @State private var showResult: Bool = false
    @State private var showEnd: Bool = false
    @State private var showInviteSheet: Bool = false
    
    // TBH-style vibrant backgrounds
    let backgrounds: [Color] = [.purple, .pink, .blue, .orange, .green]
    
    var body: some View {
        ZStack {
            backgrounds[currentPollIndex % backgrounds.count]
                .ignoresSafeArea()
            
            if viewModel.isLoading {
                ProgressView()
            } else if viewModel.polls.isEmpty {
                VStack(spacing: 16) {
                    Image(systemName: "chart.bar.doc.horizontal")
                        .font(.system(size: 50))
                        .foregroundColor(.white.opacity(0.7))
                    Text("No polls available")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Be the first to create a poll!")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
            } else if showEnd {
                VStack(spacing: 32) {
                    Spacer()
                    Text("🎉")
                        .font(.system(size: 64))
                    Text("You're all caught up!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    Text("Come back later for more polls.")
                        .font(.title2)
                        .foregroundColor(.white.opacity(0.8))
                    Button(action: {
                        showInviteSheet = true
                    }) {
                        Text("Invite a Friend to Unlock More Polls")
                            .font(.headline)
                            .foregroundColor(.purple)
                            .padding(.horizontal, 32)
                            .padding(.vertical, 14)
                            .background(Color.white)
                            .cornerRadius(20)
                    }
                    .padding(.top, 16)
                    Spacer()
                }
                .sheet(isPresented: $showInviteSheet) {
                    ActivityView(activityItems: ["Join me on LengLeng and answer more polls! https://lengleng.app"])
                }
            } else {
                let poll = viewModel.polls[currentPollIndex]
                VStack(spacing: 32) {
                    Spacer()
                    // Progress indicator
                    Text("\(currentPollIndex + 1)/\(viewModel.polls.count)")
                        .font(.headline)
                        .foregroundColor(.white.opacity(0.8))
                        .padding(.top, 16)
                    // Emoji (if available)
                    if let emoji = poll.emoji {
                        Text(emoji)
                            .font(.system(size: 64))
                            .padding(.bottom, 8)
                    }
                    // Question
                    Text(poll.question)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    // Answer buttons
                    VStack(spacing: 20) {
                        ForEach(poll.options, id: \ .id) { option in
                            Button(action: {
                                if selectedOptionId == nil {
                                    selectedOptionId = option.id
                                    Task {
                                        await viewModel.voteOnPoll(pollId: poll.id, optionId: option.id)
                                        showResult = true
                                    }
                                }
                            }) {
                                Text(option.text)
                                    .font(.title2)
                                    .fontWeight(.semibold)
                                    .foregroundColor(selectedOptionId == option.id ? .white : .black)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 18)
                                            .fill(Color.white.opacity(selectedOptionId == option.id ? 0.7 : 1.0))
                                    )
                                    .shadow(radius: 2)
                            }
                            .disabled(selectedOptionId != nil)
                        }
                    }
                    .padding(.horizontal, 24)
                    Spacer()
                    // Shuffle and Skip
                    HStack {
                        Button(action: {
                            // Shuffle: go to a random poll
                            if !viewModel.polls.isEmpty {
                                currentPollIndex = Int.random(in: 0..<viewModel.polls.count)
                                selectedOptionId = nil
                                showResult = false
                            }
                        }) {
                            HStack {
                                Image(systemName: "shuffle")
                                Text("Shuffle")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(20)
                        }
                        Spacer()
                        Button(action: {
                            // Skip: go to next poll
                            if currentPollIndex < viewModel.polls.count - 1 {
                                currentPollIndex += 1
                            } else {
                                showEnd = true
                            }
                            selectedOptionId = nil
                            showResult = false
                        }) {
                            HStack {
                                Text("Skip")
                                Image(systemName: "arrow.right")
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 12)
                            .background(Color.white.opacity(0.2))
                            .cornerRadius(20)
                        }
                    }
                    .padding(.horizontal, 32)
                    .padding(.bottom, 32)
                }
                // Feedback/result overlay
                .overlay(
                    Group {
                        if showResult, let selectedOption = poll.options.first(where: { $0.id == selectedOptionId }) {
                            VStack(spacing: 24) {
                                Spacer()
                                Text("You made their day!")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                Text(selectedOption.text)
                                    .font(.title2)
                                    .foregroundColor(.white)
                                    .padding(.horizontal)
                                Spacer()
                                Button(action: {
                                    // Advance to next poll
                                    if currentPollIndex < viewModel.polls.count - 1 {
                                        currentPollIndex += 1
                                    } else {
                                        showEnd = true
                                    }
                                    selectedOptionId = nil
                                    showResult = false
                                }) {
                                    Text("Continue")
                                        .font(.headline)
                                        .foregroundColor(.purple)
                                        .padding(.horizontal, 32)
                                        .padding(.vertical, 14)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                }
                                .padding(.bottom, 32)
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.black.opacity(0.7).ignoresSafeArea())
                        }
                    }
                )
            }
        }
        .navigationBarHidden(true)
        .onAppear {
            Task {
                await viewModel.fetchPolls()
            }
        }
    }
}

class PollsViewModel: ObservableObject {
    @Published var polls: [Poll] = []
    
    init() {
        Task {
            await fetchPolls()
        }
    }
    
    @MainActor
    func fetchPolls() async {
        FirebaseService.shared.fetchPolls { [weak self] result in
            switch result {
            case .success(let polls):
                self?.polls = polls
            case .failure(let error):
                print("Error fetching polls: \(error)")
            }
        }
    }
    
    @MainActor
    func voteOnPoll(pollId: String, optionId: String) async {
        FirebaseService.shared.voteOnPoll(pollId: pollId, optionId: optionId) { [weak self] result in
            switch result {
            case .success:
                Task {
                    await self?.fetchPolls()
                }
            case .failure(let error):
                print("Error voting on poll: \(error)")
            }
        }
    }
}

struct ActivityView: UIViewControllerRepresentable {
    let activityItems: [Any]
    let applicationActivities: [UIActivity]? = nil
    func makeUIViewController(context: Context) -> UIActivityViewController {
        UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
    }
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {}
} 