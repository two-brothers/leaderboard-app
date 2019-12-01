package com.twobrothers.leaderboard.games.models

data class FirebaseGame(
    val title: String = ""
) {
    fun toGameModel(id: String): Game {
        return Game(
            id,
            title
        )
    }
}