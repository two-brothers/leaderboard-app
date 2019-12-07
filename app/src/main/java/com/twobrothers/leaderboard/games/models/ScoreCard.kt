package com.twobrothers.leaderboard.games.models

import com.twobrothers.leaderboard.players.models.Player

data class ScoreCard(
    val id: Int,
    val player: Player,
    val score: Int
)