package com.twobrothers.leaderboard.sports.models

data class FirebaseSportsModel(
    val title: String
) {
    fun toSportsModel(): SportsModel {
        return SportsModel(
            title
        )
    }
}