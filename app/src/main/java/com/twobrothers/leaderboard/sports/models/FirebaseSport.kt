package com.twobrothers.leaderboard.sports.models

data class FirebaseSport(
    val title: String = ""
) {
    fun toSportsModel(): Sport {
        return Sport(
            title
        )
    }
}