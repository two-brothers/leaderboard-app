package com.twobrothers.leaderboard.core.responces

import com.google.firebase.firestore.DocumentReference
import com.twobrothers.leaderboard.core.lookups.GameType
import com.twobrothers.leaderboard.games.models.Game

data class FirebaseGame(
    val title: String = "",
    val leaders: List<FirebaseScoreCard> = listOf(),
    val gameType: Int = GameType.POSITION.id
) {
    fun toGameModel(id: String): Game {
        return Game(
            id,
            title,
            GameType.getById(gameType) ?: GameType.POSITION
        )
    }
}

data class FirebaseScoreCard(
    val player: DocumentReference? = null,
    val score: Int = 0
)