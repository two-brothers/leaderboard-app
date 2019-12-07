package com.twobrothers.leaderboard.games.models

import com.google.firebase.firestore.DocumentReference

data class FirebaseGame(
    val title: String = "",
    val leaders: List<FirebaseScoreCard> = listOf()
) {
    fun toGameModel(id: String): Game {
        return Game(
            id,
            title
        )
    }
}

data class FirebaseScoreCard(
    val player: DocumentReference? = null,
    val score: Int = 0
)

data class FirebasePlayer(
    val name: String = ""
) {
    fun toPlayer(): Player {
        return Player(name)
    }
}

data class Player(
    val name: String
)