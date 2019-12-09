package com.twobrothers.leaderboard.games.models

import com.twobrothers.leaderboard.core.lookups.GameType

data class Game(
    val id: String,
    val title: String,
    val gameType: GameType
)