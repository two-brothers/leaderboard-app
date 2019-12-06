package com.twobrothers.leaderboard.games.models

data class FirebaseGame(
    val title: String = "",
    val leaders: List<FirebaseScoreCard> = listOf()
) {
    fun toGameModel(id: String): Game {
        return Game(
            id,
            title,
            leaders.take(10).sortedBy { it.score }.mapIndexed { i, it ->
                it.toScoreCard(i)
            }
        )
    }
}

data class FirebaseScoreCard(
    val score: Int = 0
) {
    fun toScoreCard(id: Int): ScoreCard {
        return ScoreCard(
            id,
            score
        )
    }
}