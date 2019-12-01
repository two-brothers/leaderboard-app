package com.twobrothers.leaderboard.sports.models

data class FirebaseSport(
    val title: String = ""
) {
    fun toSportsModel(id: String): Sport {
        return Sport(
            id,
            title
        )
    }
}