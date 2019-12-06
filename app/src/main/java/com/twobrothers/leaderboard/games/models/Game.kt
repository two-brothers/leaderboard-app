package com.twobrothers.leaderboard.games.models

data class Game(
    val id: String,
    val title: String,
    val scores: List<ScoreCard>
)