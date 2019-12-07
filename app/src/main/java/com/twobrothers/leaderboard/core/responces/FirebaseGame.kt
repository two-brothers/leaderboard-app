package com.twobrothers.leaderboard.core.responces

import com.google.firebase.firestore.DocumentReference
import com.twobrothers.leaderboard.games.models.Game

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